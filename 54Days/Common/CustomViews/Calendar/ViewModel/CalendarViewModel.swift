import Foundation

protocol CalendarViewModelDelegate: class {
	func didUpdateMonths()
}

class CalendarViewModel {
	fileprivate let kCurrentMonthPageIndex = 1
	
	weak var delegate: CalendarViewModelDelegate?
	
	var currentYearTitle: String {
		get {
			return currentMonth?.monthOfYear.formattedTitle(withFormat: "yyyy") ?? ""
		}
	}
	
	var currentMonthTitle: String {
		get {
			return currentMonth?.monthOfYear.formattedTitle(withFormat: "MMMM") ?? ""
		}
	}
	
	var weekdayTitles: [String] = DayOfWeek.titles(withLength: .medium)
	
	var calendarMonths: [CalendarMonth] = []
	var currentMonth: CalendarMonth? {
		get {
			guard calendarMonths.count > 0 else { return nil }
			return calendarMonths[kCurrentMonthPageIndex]
		}
	}
	
	// MARK: Initialization & Update
	init() {
		let currentDateComponentized = Date().componentize(into: [.year, .month])
		if let currentMonth = currentDateComponentized.month,
			let currentYear = currentDateComponentized.year {
			let currentMonthOfYear = MonthOfYear(rawValue: currentMonth, year: currentYear)
			updateCalendarMonths(around: currentMonthOfYear)
		}
	}
	
	func updateCalendarMonths(around month: MonthOfYear) {
		let previousMonth = month.previousMonth()
		let nextMonth = month.nextMonth()
		
		calendarMonths = [previousMonth, month, nextMonth].map {
			return calendarMonth(of: $0)
		}
	}
	
	fileprivate func calendarMonth(of month: MonthOfYear) -> CalendarMonth {
		return CalendarMonth(monthOfYear: month,
		                     preDates: preDates(of: month),
		                     inDates: inDates(of: month),
		                     postDates: postDates(of: month))
	}
	
	fileprivate func preDates(of month: MonthOfYear) -> [Date] {
		guard let firstInDate = firstInDate(of: month),
			  let firstInDateWeekDay = firstInDate.weekday else{
			return []
		}
		
		let numberOfPreDatesNeeded = firstInDateWeekDay - 1
		
		guard let preDatesStart = Calendar.current.date(byAdding: .day, value: -numberOfPreDatesNeeded, to: firstInDate) else {
			return []
		}
		
		var preDates: [Date] = []
		for i in 0..<numberOfPreDatesNeeded {
			guard let preDate = Calendar.current.date(byAdding: .day, value: i, to: preDatesStart) else {
				return []
			}
			
			preDates.append(preDate)
		}
		
		return preDates
	}
	
	fileprivate func inDates(of month: MonthOfYear) -> [Date] {
		guard let firstInDate = firstInDate(of: month) else {
				return []
		}
		
		var inDates: [Date] = []
		for i in 0..<month.numberOfDays {
			guard let inDate = Calendar.current.date(byAdding: .day, value: i, to: firstInDate) else {
				return []
			}
			
			inDates.append(inDate)
		}
		
		return inDates
	}
	
	fileprivate func postDates(of month: MonthOfYear) -> [Date] {
		guard let lastInDate = lastInDate(of: month),
			  let lastInDateWeekday = lastInDate.weekday else {
			return []
		}
		
		let numberOfPostDatesNeeded = 7 - lastInDateWeekday

		guard let postDatesStart = Calendar.current.date(byAdding: .day, value: 1, to: lastInDate) else {
			return []
		}
		
		var postDates: [Date] = []
		for i in 0..<numberOfPostDatesNeeded {
			guard let postDate = Calendar.current.date(byAdding: .day, value: i, to: postDatesStart) else {
				return []
			}
			
			postDates.append(postDate)
		}
		
		return postDates
	}
	
	fileprivate func firstInDate(of month: MonthOfYear) -> Date? {
		return Calendar.current.date(from: DateComponents(year: month.associatedYear, month: month.rawValue))
	}
	
	fileprivate func lastInDate(of month: MonthOfYear) -> Date? {
		if let firstInDate = firstInDate(of: month),
			let lastDate = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: firstInDate) {
			return lastDate
		} else {
			return nil
		}
	}
}

// MARK: User Interaction
extension CalendarViewModel {
	func updateMonthsBasedOnNewPage(withIndex index: Int) {
		guard index != kCurrentMonthPageIndex else {
			return
		}
		
		if index < kCurrentMonthPageIndex {
			shiftMonthsRight()
		} else {
			shiftMonthsLeft()
		}
	}
	
	private func shiftMonthsLeft() {
		guard let newNextMonth = calendarMonths.last?.monthOfYear.nextMonth() else {
			return
		}
		
		let newNextCalendarMonth = calendarMonth(of: newNextMonth)
		var newCalendarMonths = Array(calendarMonths.dropFirst())
		newCalendarMonths.append(newNextCalendarMonth)
		
		calendarMonths = newCalendarMonths
		
		delegate?.didUpdateMonths()
	}
	
	private func shiftMonthsRight() {
		guard let newPreviousMonth = calendarMonths.first?.monthOfYear.previousMonth() else {
			return
		}
		
		let newPreviousCalendarMonth = calendarMonth(of: newPreviousMonth)
		var newCalendarMonths = [newPreviousCalendarMonth]
		newCalendarMonths.append(contentsOf: Array(calendarMonths.dropLast()))
		
		calendarMonths = newCalendarMonths
		
		delegate?.didUpdateMonths()
	}
}

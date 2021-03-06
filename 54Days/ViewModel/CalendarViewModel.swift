import Foundation

class CalendarViewModel {
	private static let centerCalendarMonthIndex: Int = 1
	private static let numberOfCalendarMonths: Int = 3

	private var yearToDisplay: String {
		get {
			return currentMonth?.monthOfYear.title(withFormat: "yyyy") ?? ""
		}
	}

	private var monthToDisplay: String {
		get {
			return currentMonth?.monthOfYear.title(withFormat: "MMMM") ?? ""
		}
	}

	private var currentMonth: CalendarMonth? {
		get {
			return calendarMonths.getItem(at: CalendarViewModel.centerCalendarMonthIndex)
		}
	}

	private var weekdayTitles: [String] = DayOfWeek.titles(withLength: .medium)

	private(set) var calendarMonths: [CalendarMonth] = []

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
		let previousMonth = month.previousMonthOfYear
		let nextMonth = month.nextMonthOfYear

		calendarMonths = [previousMonth, month, nextMonth].map {
			return calendarMonth(of: $0)
		}
	}

	private func calendarMonth(of month: MonthOfYear) -> CalendarMonth {
		return CalendarMonth(monthOfYear: month,
		                     preDates: preDates(of: month),
		                     inDates: inDates(of: month),
		                     postDates: postDates(of: month))
	}

	private func preDates(of month: MonthOfYear) -> [Date] {
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

	private func inDates(of month: MonthOfYear) -> [Date] {
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

	private func postDates(of month: MonthOfYear) -> [Date] {
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

	private func firstInDate(of month: MonthOfYear) -> Date? {
		return Calendar.current.date(from: DateComponents(year: month.associatedYear, month: month.rawValue))
	}

	private func lastInDate(of month: MonthOfYear) -> Date? {
		if let firstInDate = firstInDate(of: month),
			let lastDate = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: firstInDate) {
			return lastDate
		} else {
			return nil
		}
	}
}

extension CalendarViewModel {
	func getYearAndMonth(completion: @escaping ((String, String) -> Void)) {
		completion(yearToDisplay, monthToDisplay)
	}

	func getWeekdayTitles(completion: @escaping (([String]) -> Void)) {
		completion(weekdayTitles)
	}

	func shiftCalendarMonthsLeft(completion: @escaping(() -> Void)) {
		guard let newNextMonth = calendarMonths.last?.monthOfYear.nextMonthOfYear else {
			return
		}
		
		let newNextCalendarMonth = calendarMonth(of: newNextMonth)
		var newCalendarMonths = Array(calendarMonths.dropFirst())
		newCalendarMonths.append(newNextCalendarMonth)
		
		calendarMonths = newCalendarMonths
		
		completion()
	}
	
	func shiftCalendarMonthsRight(completion: @escaping(() -> Void)) {
		guard let newPreviousMonth = calendarMonths.first?.monthOfYear.previousMonthOfYear else {
			return
		}
		
		let newPreviousCalendarMonth = calendarMonth(of: newPreviousMonth)
		var newCalendarMonths = [newPreviousCalendarMonth]
		newCalendarMonths.append(contentsOf: Array(calendarMonths.dropLast()))
		
		calendarMonths = newCalendarMonths
		
		completion()
	}
}

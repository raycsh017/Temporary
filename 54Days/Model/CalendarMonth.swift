import Foundation

struct CalendarMonth {
	let monthOfYear: MonthOfYear
	let preDates: [Date]
	let inDates: [Date]
	let postDates: [Date]
	let dates: [Date]
	let preDatesIndexRange: Range<Int>
	let inDatesIndexRange: Range<Int>
	let postDatesIndexRange: Range<Int>

	init(monthOfYear: MonthOfYear, preDates: [Date], inDates: [Date], postDates: [Date]) {
		var dates: [Date] = []
		dates.append(contentsOf: preDates)
		dates.append(contentsOf: inDates)
		dates.append(contentsOf: postDates)

		self.monthOfYear = monthOfYear
		self.preDates = preDates
		self.inDates = inDates
		self.postDates = postDates
		self.dates = dates
		self.preDatesIndexRange = 0 ..< preDates.count
		self.inDatesIndexRange = preDates.count ..< (preDates.count + inDates.count)
		self.postDatesIndexRange = (preDates.count + inDates.count) ..< (preDates.count + inDates.count + postDates.count)
	}
}

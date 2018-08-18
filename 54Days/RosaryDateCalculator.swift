import Foundation

class RosaryDateCalculator {
	static func rosaryEndDate(fromStartDate startDate: Date) -> Date? {
		let dateDayOffset = RosaryConstants.numberOfDaysInPeriod - 1
		
		if let endDate = Calendar.current.date(byAdding: .day, value: dateDayOffset, to: startDate) {
			return Calendar.current.startOfDay(for: endDate)
		} else {
			return nil
		}
	}
}

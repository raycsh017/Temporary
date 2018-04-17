import Foundation

extension Date {
	var dayString: String {
		guard let day = Calendar.current.dateComponents([.day], from: self).day else {
			return ""
		}
		return String(day)
	}
	
	var weekday: Int? {
		return Calendar.current.dateComponents([.weekday], from: self).weekday
	}
	
	func componentize(into components: Set<Calendar.Component>) -> DateComponents {
		return Calendar.current.dateComponents(components, from: self)
	}
}

extension Date {
	var isToday: Bool {
		return self.isOnSameDay(as: Date())
	}
	
	func isOnSameDay(as date: Date) -> Bool {
		let startOfSelfDate = Calendar.current.startOfDay(for: self)
		let startOfTargetDate = Calendar.current.startOfDay(for: date)
		return startOfSelfDate == startOfTargetDate
	}
}

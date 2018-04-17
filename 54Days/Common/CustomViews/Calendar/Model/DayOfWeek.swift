import Foundation

enum DayOfWeek: Int {
	case sun = 0
	case mon
	case tue
	case wed
	case thu
	case fri
	case sat
	
	enum TitleLength {
		case short
		case medium
		case long
	}
	
	var title: String {
		switch self {
		case .sun:
			return "Sunday"
		case .mon:
			return "Monday"
		case .tue:
			return "Tuesday"
		case .wed:
			return "Wednesday"
		case .thu:
			return "Thursday"
		case .fri:
			return "Friday"
		case .sat:
			return "Saturday"
		}
	}
	
	func title(withLength length: TitleLength) -> String {
		switch length {
		case .short:
			let startIndex = title.startIndex
			let lastIndex = title.startIndex
			return String(title[startIndex..<lastIndex])
		case .medium:
			let startIndex = title.startIndex
			let lastIndex = title.index(title.startIndex, offsetBy: 3)
			return String(title[startIndex..<lastIndex])
		case .long:
			return title
		}
	}
	
	static func titles(withLength length: TitleLength) -> [String] {
		return DayOfWeek.all.map { $0.title(withLength: length) }
	}
	
	static let all: [DayOfWeek] = [.sun, .mon, .tue, .wed, .thu, .fri, .sat]
}

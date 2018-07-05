import Foundation

enum MonthOfYear {
	case jan(Int)
	case feb(Int)
	case mar(Int)
	case apr(Int)
	case may(Int)
	case jun(Int)
	case jul(Int)
	case aug(Int)
	case sep(Int)
	case oct(Int)
	case nov(Int)
	case dec(Int)

	init(rawValue: Int, year: Int) {
		switch rawValue {
		case 1: self = .jan(year)
		case 2: self = .feb(year)
		case 3: self = .mar(year)
		case 4: self = .apr(year)
		case 5: self = .may(year)
		case 6: self = .jun(year)
		case 7: self = .jul(year)
		case 8: self = .aug(year)
		case 9: self = .sep(year)
		case 10: self = .oct(year)
		case 11: self = .nov(year)
		case 12: self = .dec(year)
		default:
			self = .jan(year)
		}
	}

	var rawValue: Int {
		switch self {
		case .jan: return 1
		case .feb: return 2
		case .mar: return 3
		case .apr: return 4
		case .may: return 5
		case .jun: return 6
		case .jul: return 7
		case .aug: return 8
		case .sep: return 9
		case .oct: return 10
		case .nov: return 11
		case .dec: return 12
		}
	}

	var associatedYear: Int {
		switch self {
		case .jan(let year),
		     .feb(let year),
		     .mar(let year),
		     .apr(let year),
		     .may(let year),
		     .jun(let year),
		     .jul(let year),
		     .aug(let year),
		     .sep(let year),
		     .oct(let year),
		     .nov(let year),
		     .dec(let year):
			return year
		}
	}

	var numberOfDays: Int {
		switch self {
		case .jan, .mar, .may, .jul, .aug, .oct, .dec:
			return 31
		case .apr, .jun, .sep, .nov:
			return 30
		case .feb(let year):
			guard let firstDateOfFebruary = Calendar.current.date(from: DateComponents(year: year, month: 2)),
				let numberOfDatesInFebruary = Calendar.current.range(of: .day, in: .month, for: firstDateOfFebruary)?.count else {
				return 28
			}
			return numberOfDatesInFebruary
		}
	}

	var previousMonthOfYear: MonthOfYear {
		switch self {
		case .jan(let year):
			return .dec(year - 1)
		default:
			return MonthOfYear(rawValue: self.rawValue - 1, year: self.associatedYear)
		}
	}

	var nextMonthOfYear: MonthOfYear {
		switch self {
		case .dec(let year):
			return .jan(year + 1)
		default:
			return MonthOfYear(rawValue: self.rawValue + 1, year: self.associatedYear)
		}
	}

	func title(withFormat format: String = "MMMM yyyy") -> String? {
		guard let currentMonthDateForm = currentMonthInDateForm() else {
			return nil
		}
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.string(from: currentMonthDateForm)
	}

	private func currentMonthInDateForm() -> Date? {
		let month = rawValue
		let year = associatedYear
		
		let currentMonthDateComponents = DateComponents(year: year, month: month)
		let currentMonthDateForm = Calendar.current.date(from: currentMonthDateComponents)
		
		return currentMonthDateForm
	}
}

//enum PrayersTableSection {
//	case miniCalendar
//	case rosaryPrayers([RosaryMysteryType])
//	case otherPrayers([OtherPrayerType])
//	
//	var title: String? {
//		switch self {
//		case .miniCalendar:
//			return nil
//		case .rosaryPrayers:
//			return "묵주기도"
//		case .otherPrayers:
//			return "기타기도"
//		}
//	}
//	
//	var numberOfCells: Int {
//		switch self {
//		case .miniCalendar:
//			return 1
//		case .rosaryPrayers(let mysteries):
//			return 1
//		case .otherPrayers(let prayers):
//			return prayers.count
//		}
//	}
//	
//	static let all: [PrayersTableSection] = [.miniCalendar, .rosaryPrayers(RosaryMysteryType.all), .otherPrayers(OtherPrayerType.all)]
//}

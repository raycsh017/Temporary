import UIKit

enum PrayerType {
	case rosary(RosaryMysteryType)
	case other
	
	var key: String {
		switch self {
		case .rosary(let mystery):
			return mystery.key
		case .other:
			return "other"
		}
	}
	
	var title: String {
		switch self {
		case .rosary(let mystery):
			return mystery.inKorean
		case .other:
			return "주요 기도문"
		}
	}
	
	var icon: UIImage? {
		switch self{
		case .rosary(let mystery):
			return mystery.icon
		case .other:
			return UIImage(named: "ic_pray")
		}
	}
	
	static let all: [PrayerType] = [.rosary(.joyful), .rosary(.light), .rosary(.sorrowful), .rosary(.glorious), .other]
}

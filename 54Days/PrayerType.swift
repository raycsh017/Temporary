import UIKit

enum PrayerType {
	case rosary(RosaryMystery.MysteryType)
	case other
	
	var key: String {
		switch self {
		case .rosary(let mystery):
			return mystery.key
		case .other:
			return "other"
		}
	}
	
	var koreanTitle: String {
		switch self {
		case .rosary(let mystery):
			return mystery.koreanTitle
		case .other:
			return "주요 기도문"
		}
	}
	
	var assignedIcon: UIImage? {
		switch self {
		case .rosary(let mystery):
			return mystery.assignedIcon
		case .other:
			return UIImage(named: "ic_cross")
		}
	}
	
	var assignedColor: UIColor? {
		switch self {
		case .rosary(let mystery):
			return mystery.assignedColor
		case .other:
			return Color.StarDust
		}
	}
	
	static let all: [PrayerType] = [.rosary(.joyful), .rosary(.light), .rosary(.sorrowful), .rosary(.glorious), .other]
}

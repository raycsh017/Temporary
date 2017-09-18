import UIKit

enum RosaryMysteryType: String {
	case joyful
	case light
	case sorrowful
	case glorious
	
	var key: String {
		switch self {
		case .joyful:
			return "joyful"
		case .light:
			return "light"
		case .sorrowful:
			return "sorrowful"
		case .glorious:
			return "glorious"
		}
	}
	
	var icon: UIImage? {
		switch self {
		case .joyful:
			return UIImage(named: "ic_star")
		case .light:
			return UIImage(named: "ic_fish")
		case .sorrowful:
			return UIImage(named: "ic_crown_thorns")
		case .glorious:
			return UIImage(named: "ic_cross")
		}
	}
	
	var color: UIColor {
		switch self {
		case .joyful:
			return Color.Tacao
		case .light:
			return Color.ChelseaCucumber
		case .sorrowful:
			return Color.DarkTerraCotta
		case .glorious:
			return Color.DarkSlateBlue
		}
	}
	
	var inKorean: String{
		switch self {
		case .joyful:
			return "환희의 신비"
		case .light:
			return "빛의 신비"
		case .sorrowful:
			return "고통의 신비"
		case .glorious:
			return "영광의 신비"
		}
	}
	
	static let all: [RosaryMysteryType] = [.joyful, .light, .sorrowful, .glorious]
}

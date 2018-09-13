import Foundation
import UIKit

struct RosaryMystery {
	enum MysteryType: String {
		case joyful
		case light
		case sorrowful
		case glorious
	}
	
	struct StartingPrayer {
		let petition: String
		let grace: String
	}
	
	struct SubMysteryPrayer {
		let title: String
		let subText: String
		let mainText: String
		let endingText: String
	}
	
	struct FinishingPrayer {
		let spirit: String
		let petition: String
		let grace: String
		let praise1: [String]
		let praise2: String
	}
	
	let type: MysteryType
	let startingPrayer: StartingPrayer
	let subMysteryPrayers: [SubMysteryPrayer]
	let finishingPrayer: FinishingPrayer
}

extension RosaryMystery.MysteryType {
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
	
	var koreanTitle: String{
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

	var assignedIcon: UIImage? {
		switch self {
		case .joyful:
			return UIImage(named: "ic_joyful")
		case .light:
			return UIImage(named: "ic_light")
		case .sorrowful:
			return UIImage(named: "ic_sorrowful")
		case .glorious:
			return UIImage(named: "ic_glorious")
		}
	}

	var assignedColor: UIColor {
		switch self {
		case .joyful:
			return Color.Rosary.Yellow
		case .light:
			return Color.Rosary.Green
		case .sorrowful:
			return Color.Rosary.Red
		case .glorious:
			return Color.Rosary.Purple
		}
	}

	static let all: [RosaryMystery.MysteryType] = [.joyful, .light, .sorrowful, .glorious]
}

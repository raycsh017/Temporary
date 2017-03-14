//
//  MainMenu.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/6/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation
import UIKit

struct Menu{
	let title: String
	let icon: UIImage
	let id: Int
}

enum MainMenu: Int{
	case joyfulMystery
	case lightMystery
	case sorrowfulMystery
	case gloriousMystery
	case commonPrayer
	case calendar
	
	var title: String{
		switch self {
		case .joyfulMystery:
			return "환희의 신비"
		case .lightMystery:
			return "빛의 신비"
		case .sorrowfulMystery:
			return "고통의 신비"
		case .gloriousMystery:
			return "영광의 신비"
		case .commonPrayer:
			return "주요 기도문"
		case .calendar:
			return "달력"
		}
	}
	var icon: UIImage{
		switch self {
		case .joyfulMystery:
			return UIImage(named: "ic_star")!
		case .lightMystery:
			return UIImage(named: "ic_fish")!
		case .sorrowfulMystery:
			return UIImage(named: "ic_crown_thorns")!
		case .gloriousMystery:
			return UIImage(named: "ic_cross")!
		case .commonPrayer:
			return UIImage(named: "ic_pray")!
		case .calendar:
			return UIImage(named: "ic_calendar")!
		}
	}
	static let all: [MainMenu] = [.joyfulMystery, .lightMystery, .sorrowfulMystery, .gloriousMystery, .commonPrayer, .calendar]
}

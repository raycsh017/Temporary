//
//  RosaryMystery.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 3/11/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation
import UIKit

// Rosary mystery types
enum RosaryMysteryType: Int{
	case joyful
	case light
	case sorrowful
	case glorious
	
	init?(rawString: String){
		switch rawString{
		case "joyful":
			self = .joyful
		case "light":
			self = .light
		case "sorrowful":
			self = .sorrowful
		case "glorious":
			self = .glorious
		default:
			return nil
		}
	}
	
	var icon: UIImage{
		switch self {
		case .joyful:
			return UIImage(named: "ic_star")!
		case .light:
			return UIImage(named: "ic_fish")!
		case .sorrowful:
			return UIImage(named: "ic_crown_thorns")!
		case .glorious:
			return UIImage(named: "ic_cross")!
		}
	}
	
	var inKorean: String{
		switch self{
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
	
	var inEnglish: String{
		switch self{
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
	
	static let all: [RosaryMysteryType] = [.joyful, .light, .sorrowful, .glorious]
}

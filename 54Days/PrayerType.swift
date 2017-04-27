//
//  PrayerType.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 4/18/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation
import UIKit

//enum PrayerType{
//	case rosary
//	case general
//	
//	var title: String{
//		switch self{
//		case .rosary:
//			return "묵주기도"
//		case .general:
//			return "기타기도"
//		}
//	}
//}
//
//struct PrayerItem{
//	let type: PrayerType
//	let title: String
//	let icon: UIImage
//}


enum PrayerType{
	case rosary([RosaryMysteryType])
	case general([GeneralPrayerType])
	
	var inKorean: String{
		switch self{
		case .rosary:
			return "묵주기도"
		case .general:
			return "기타기도"
		}
	}

	var data: [Any]{
		switch self{
		case .rosary(let rosaryTypes):
			return rosaryTypes
		case .general(let generalTypes):
			return generalTypes
		}
	}
	
	static let all: [PrayerType] = [
		.rosary(RosaryMysteryType.all),
		.general(GeneralPrayerType.all)
	]
}

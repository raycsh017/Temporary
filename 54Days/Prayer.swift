//
//  Prayer.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 4/19/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation

enum Prayer{
	case rosary(RosaryPrayer)
	case general([GeneralPrayer])
	
	var hasSectionHeaders: Bool{
		switch self{
		case .rosary:
			return true
		case .general:
			return false
		}
	}
	
	var sectionTitles: [String]{
		switch self{
		case .rosary:
			return ["시작기도", "신비기도", "마침기도"]
		case .general:
			return []
		}
	}
	
	var numItemsPerSection: [Int]{
		switch self{
		case .rosary:
			return [1, 5, 1]
		case .general(let prayer):
			return [prayer.count]
		}
	}
	
	var currentTitle: String{
		switch self{
		case .rosary(let rosaryPrayer):
			return rosaryPrayer.mystery.type.inKorean
		case .general:
			return "주요 기도문"
		}
	}
}

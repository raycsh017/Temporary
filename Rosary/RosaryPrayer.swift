//
//  RosaryPrayer.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/13/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation

// Data structure for storing Rosary prayer data
// Composed of 3 parts: Starting, Main(mystery sections), Ending
class RosaryPrayer{
	let mystery: RosaryMystery
	let startingPrayer: RosaryStartingPrayer
	let endingPrayer: RosaryEndingPrayer
	
	init(mystery: RosaryMystery, startingPrayer: RosaryStartingPrayer, endingPrayer: RosaryEndingPrayer) {
		
		self.mystery = mystery
		self.startingPrayer = startingPrayer
		self.endingPrayer = endingPrayer
	}
}

class RosaryMystery{
	let type: RosaryMysteryType
	var sections: [RosaryMysterySection] = []
	
	struct RosaryMysterySection{
		let title: String
		let subText: String
		let mainText: String
		let endingText: String
	}
	
	init(type: RosaryMysteryType) {
		self.type = type
	}
	
	func addSection(title: String, subText: String, mainText: String, endingText: String){
		let section = RosaryMysterySection(title: title, subText: subText, mainText: mainText, endingText: endingText)
		self.sections.append(section)
	}
}

class RosaryStartingPrayer{
	let petition: String
	let grace: String
	
	init(petition: String, grace: String){
		self.petition = petition
		self.grace = grace
	}
}

class RosaryEndingPrayer{
	let spirit: String
	let petition: String
	let grace: String
	let praise1: [String]
	let praise2: String
	
	init(spirit: String, petition: String, grace: String, praise1: [String], praise2: String) {
		self.spirit = spirit
		self.petition = petition
		self.grace = grace
		self.praise1 = praise1
		self.praise2 = praise2
	}
}

//
//  RosaryPrayer.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/13/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation

struct RosaryMystery{
	let type: RosaryMysteryType
	var sections: [RosaryMysterySection]
	var startingPrayer: RosaryStartingPrayer
	var endingPrayer: RosaryEndingPrayer
}
struct RosaryStartingPrayer{
	let petition: String
	let grace: String
}
struct RosaryEndingPrayer{
	let spirit: String
	let petition: String
	let grace: String
	let praise1: [String]
	let praise2: String
}
struct RosaryMysterySection{
	let title: String
	let subText: String
	let mainText: String
	let endingText: String
}

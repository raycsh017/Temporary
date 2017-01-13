//
//  RosaryPrayers.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 1/6/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation

enum Rosary{
	case joyful
	case light
	case sorrowful
	case glorious
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
struct RosaryMainPrayer{
	var mysteries: [String: [RosaryMysterySection]]
}
struct RosaryMysterySection{
	let title: String
	let subText: String
	let mainText: String
	let endingText: String
}

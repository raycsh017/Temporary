//
//  Prayer
//  Rosary
//
//  Created by Sang Hyuk Cho on 1/12/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation

// Data structure for storing general prayer data
class GeneralPrayer{
	let title: String
	let text: NSMutableAttributedString
	let numberOfLines: Int
	
	init(title: String, text: NSMutableAttributedString, numberOfLines: Int) {
		self.title = title
		self.text = text
		self.numberOfLines = numberOfLines
	}
}

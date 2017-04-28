//
//  ArrayExtension.swift
//  54Days
//
//  Created by Sang Hyuk Cho on 4/28/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation

extension Array{
	func prettyFormat()->String?{
		guard let stringArray = self as? [String] else{
			return nil
		}
		
		var formattedString = ""
		for i in 0..<(stringArray.count - 1){
			formattedString += stringArray[i]
			formattedString += "\n"
		}
		formattedString += stringArray[stringArray.count - 1]
		return formattedString
	}
}

//
//  StringExtension.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/25/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation
import UIKit

extension NSString{
	func getEstimatedHeight(with width: CGFloat, font: UIFont) -> CGFloat{
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
		
		return ceil(boundingBox.height)
	}
}
extension NSAttributedString{
	func getEstimatedHeight(with width: CGFloat, font: UIFont) -> CGFloat{
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
		
		return boundingBox.height
	}
}

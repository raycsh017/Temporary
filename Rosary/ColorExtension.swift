//
//  ColorExtension.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 12/29/16.
//  Copyright © 2016 sang. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
	class func withRGB(red: CGFloat, green: CGFloat, blue: CGFloat)->UIColor{
		return UIColor(red: (red/255), green: (green/255), blue: (blue/255), alpha: 1)
	}
}



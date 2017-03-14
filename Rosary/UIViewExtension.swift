//
//  UIViewExtension.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 1/31/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
	func addShadow(){
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOpacity = 0.3
		self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
		self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 0).cgPath
		self.layer.shouldRasterize = true
		self.layer.rasterizationScale = UIScreen.main.scale
	}
}

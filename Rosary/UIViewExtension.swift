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
//	func deepenShadow(){
//		UIView.animate(withDuration: 0.2) {
//			self.frame.origin.x = self.frame.origin.x - 5.0
//			self.frame.origin.y = self.frame.origin.y - 5.0
//			self.layer.shadowOpacity = 0.5
//			self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
//		}
//	}
//	func ligntenShadow(){
//		UIView.animate(withDuration: 0.2) {
//			self.frame.origin.x = self.frame.origin.x + 5.0
//			self.frame.origin.y = self.frame.origin.y + 5.0
//			self.layer.shadowOpacity = 0.3
//			self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
//		}
//	}
}

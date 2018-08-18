//
//  UIView+TableView.swift
//  54Days
//
//  Created by Sang Hyuk Cho on 7/14/18.
//  Copyright © 2018 sang. All rights reserved.
//

import UIKit

extension UIView {
	func resizeForTableHeaderAndFooter() {
		layoutIfNeeded()
		
		let targetWidth = UIScreen.main.bounds.width
		let targetHeight = UILayoutFittingCompressedSize.height
		let targetSize = self.systemLayoutSizeFitting(CGSize(width: targetWidth, height: targetHeight))
		
		self.frame.size.height = targetSize.height
	}
}

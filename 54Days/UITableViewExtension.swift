//
//  UITableViewExtension.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 4/20/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell{
	func setValues(mainText: String, detailText: String){
		self.textLabel?.text = mainText
		self.detailTextLabel?.text = detailText
	}
}

//
//  RosaryMenuCollectionViewCell.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 1/29/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class PrayersListCollectionViewCell: UICollectionViewCell {
	
	static let identifier = "PrayersListCell"
	
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setup()
	}
	
	
	
	func setup(){
		self.clipsToBounds = false
	}
	func setValues(title: String, icon: UIImage){
		self.titleLabel.text = title
		self.iconImageView.image = icon
	}
}

//
//  CommonPrayerCollectionViewCell.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/25/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class CommonPrayerCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var prayerTitleLabel: UILabel!
	@IBOutlet weak var prayerTextLabel: UILabel!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setup()
	}
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		self.setup()
	}
	
	func setup(){
		self.clipsToBounds = false
	}
	func setValues(title: String, attributedText: NSMutableAttributedString){
		self.prayerTitleLabel.text = title
		self.prayerTextLabel.attributedText = attributedText
	}
}

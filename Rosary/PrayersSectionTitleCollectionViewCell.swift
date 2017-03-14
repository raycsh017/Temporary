//
//  PrayersSectionTitleCollectionViewCell.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/27/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class PrayersSectionTitleCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var prayersSectionTitleLabel: UILabel!
	
	static let cellIdentifier = "prayersSectionTitleCell"
	
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
	func setValues(title: String){
		self.prayersSectionTitleLabel.text = title
	}
}

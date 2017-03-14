//
//  MainPrayerCollectionViewCell.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/13/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class MainPrayerCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subTextLabel: UILabel!
	@IBOutlet weak var mainTextLabel: UILabel!
	@IBOutlet weak var endingTextLabel: UILabel!
	
	static let cellIdentifier = "mainPrayerCell"
	
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
	func setValues(title: String, subText: String, mainText: String, endingText: String){
		self.titleLabel.text = title
		self.subTextLabel.text = subText
		self.mainTextLabel.text = mainText
		self.endingTextLabel.text = endingText
	}
}

//
//  StartingPrayerCollectionViewCell.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/13/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class StartingPrayerCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var petitionPrayerLabel: UILabel!
	@IBOutlet weak var gracePrayerLabel: UILabel!
	
	static let cellIdentifier = "startingPrayerCell"
	
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
	func setValues(petitionPrayer: String, gracePrayer: String){
		self.petitionPrayerLabel.text = petitionPrayer
		self.gracePrayerLabel.text = gracePrayer
	}
}

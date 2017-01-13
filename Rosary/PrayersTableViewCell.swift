//
//  PrayersTableViewCell.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 1/5/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class StartingPrayerTableViewCell: UITableViewCell {

	@IBOutlet weak var petitionPrayerLabel: UILabel!
	@IBOutlet weak var gracePrayerLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func initialize(petitionPrayer: String, gracePrayer: String){
		self.petitionPrayerLabel.text = petitionPrayer
		self.gracePrayerLabel.text = gracePrayer
	}
}

class MainPrayerTableViewCell: UITableViewCell {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subTextLabel: UILabel!
	@IBOutlet weak var mainTextLabel: UILabel!
	@IBOutlet weak var endingTextLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	func initialize(title: String, subText: String, mainText: String, endingText: String){
		self.titleLabel.text = title
		self.subTextLabel.text = subText
		self.mainTextLabel.text = mainText
		self.endingTextLabel.text = endingText
//		print(self.mainTextLabel.frame)
	}
}

class EndingPrayerTableViewCell: UITableViewCell {
	
	@IBOutlet weak var spiritPrayerLabel: UILabel!
	@IBOutlet weak var petitionPrayerLabel: UILabel!
	@IBOutlet weak var gracePrayerLabel: UILabel!
	@IBOutlet weak var praisalPrayerLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	func initialize(spiritPrayer: String, petitionPrayer: String, gracePrayer: String, praisalPrayer: String){
		self.spiritPrayerLabel.text = spiritPrayer
		self.petitionPrayerLabel.text = petitionPrayer
		self.gracePrayerLabel.text = gracePrayer
		self.praisalPrayerLabel.text = praisalPrayer
	}
}

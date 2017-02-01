//
//  PrayersTableViewCells.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 1/5/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell{

	var expanded: Bool = false
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
}

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
	}
}

class EndingPrayerTableViewCell: UITableViewCell {
	
	@IBOutlet weak var spiritPrayerLabel: UILabel!
	@IBOutlet weak var petitionPrayerLabel: UILabel!
	@IBOutlet weak var gracePrayerLabel: UILabel!
	@IBOutlet weak var praise1PrayerLabel: UILabel!
	@IBOutlet weak var praise2PrayerLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	func initialize(spiritPrayer: String, petitionPrayer: String, gracePrayer: String, praise1Prayer: [String], praise2Prayer: String){
		self.spiritPrayerLabel.text = spiritPrayer
		self.petitionPrayerLabel.text = petitionPrayer
		self.gracePrayerLabel.text = gracePrayer
		
		var praise1Combined = ""
		for i in 0..<(praise1Prayer.count){
			switch i % 2{
			case 0:
				praise1Combined += "\u{2218} "
			case 1:
				praise1Combined += "\u{2219} "
			default:
				break
			}
			praise1Combined += praise1Prayer[i]
		}
		self.praise1PrayerLabel.text = praise1Combined
		
		self.praise2PrayerLabel.text = "\u{253c}" + praise2Prayer
	}
}

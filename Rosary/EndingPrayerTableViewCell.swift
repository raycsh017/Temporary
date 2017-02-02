//
//  EndingPrayerTableViewCell.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 1/5/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

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

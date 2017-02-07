//
//  StartingPrayerTableViewCell.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/1/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation
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

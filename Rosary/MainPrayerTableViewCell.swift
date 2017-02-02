//
//  MainPrayerTableViewCell.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/1/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation
import UIKit

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

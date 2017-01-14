//
//  OtherPrayersTableViewCell.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 1/13/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class OtherPrayersTableViewCell: UITableViewCell {

	@IBOutlet weak var prayerTitleLabel: UILabel!
	@IBOutlet weak var prayerTextLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func initialize(title: String, text: String){
		
	}
}

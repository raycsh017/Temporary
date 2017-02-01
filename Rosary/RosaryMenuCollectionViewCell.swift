//
//  RosaryMenuCollectionViewCell.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 1/29/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class RosaryMenuCollectionViewCell: UICollectionViewCell {
	static let cellID = "RosaryMenuCell"
	
	@IBOutlet weak var menuIconImageView: UIImageView!{
		didSet{
			self.menuIconImageView.contentMode = .scaleAspectFit
		}
	}
	@IBOutlet weak var menuTitleLabel: UILabel!{
		didSet{
			self.menuTitleLabel.font = UIFont(name: "Helvetica Neue", size: 14.0)
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setup()
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setup()
	}
	
	func setup(){
		self.clipsToBounds = false
	}
	func initialize(title: String, icon: UIImage){
		self.menuTitleLabel.text = title
		self.menuIconImageView.image = icon
	}
}

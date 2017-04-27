//
//  PrayersListHeaderView.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 4/17/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class PrayersCollectionHeaderView: UICollectionReusableView {
	
	static let identifier = "prayersCollectionHeaderView"
	
	let titleLabel: UILabel = {
		let title = UILabel()
		title.textColor = FiftyFour.color.darkGray
		title.font = UIFont.boldSystemFont(ofSize: 14.0)
		title.textAlignment = .left
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	
	
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
		
		self.setupViews()
		self.setupConstraints()
	}
	
	func setupViews(){
		self.addSubview(self.titleLabel)
	}
	
	func setupConstraints(){
		self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
	}
	
	func setValues(title: String){
		self.titleLabel.text = title
	}
}

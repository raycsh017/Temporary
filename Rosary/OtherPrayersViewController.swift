//
//  OtherPrayersViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 1/12/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit
import SwiftyJSON

class OtherPrayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var otherPrayersTableView: UITableView!{
		didSet{
			self.otherPrayersTableView.allowsSelection = false
		}
	}
	
	let otherPrayersCellIdentifier = "otherPrayersCell"
	
	var otherPrayers: [Prayer]!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.automaticallyAdjustsScrollViewInsets = false
		self.navigationItem.title = "주요기도문"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// UITableView DataSource/Delegate functions
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return otherPrayers.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.otherPrayersCellIdentifier, for: indexPath) as? OtherPrayersTableViewCell
		let currentPrayer = self.otherPrayers[indexPath.row]
		cell?.initialize(title: currentPrayer.title, attributedText: currentPrayer.text)
		return cell!
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	
}

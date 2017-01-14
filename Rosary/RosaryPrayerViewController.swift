//
//  RosaryPrayerViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 1/11/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class RosaryPrayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var rosaryPrayerTableView: UITableView!
	
	let startingPrayerCellIdentifier = "startingPrayerCell"
	let mainPrayerCellIdentifier = "mainPrayerCell"
	let endingPrayerCellIdentifier = "endingPrayerCell"
	
	var startingPrayer: RosaryStartingPrayer!
	var mystery: String!
	var mysterySections: [RosaryMysterySection]!
	var endingPrayer: RosaryEndingPrayer!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		// Remove empty space between the tableview and the navigation bar
		self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// UITableView DataSource/Delegate functions
	func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section{
		case 0:
			return 1
		case 1:
			return self.mysterySections.count
		case 2:
			return 1
		default:
			break
		}
		return 0
	}
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section{
		case 0:
			return "시작기도"
		case 1:
			return "신비"
		case 2:
			return "마침기도"
		default:
			break
		}
		return nil
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section{
		case 0:
			let cell = tableView.dequeueReusableCell(withIdentifier: self.startingPrayerCellIdentifier, for: indexPath) as? StartingPrayerTableViewCell
			cell?.initialize(petitionPrayer: self.startingPrayer.petition, gracePrayer: self.startingPrayer.grace)
			return cell!
		case 1:
			let cell = tableView.dequeueReusableCell(withIdentifier: self.mainPrayerCellIdentifier, for: indexPath) as? MainPrayerTableViewCell
			let mysterySection = self.mysterySections[indexPath.row]
			cell?.initialize(title: mysterySection.title, subText: mysterySection.subText, mainText: mysterySection.mainText, endingText: mysterySection.endingText)
			return cell!
		case 2:
			let cell = tableView.dequeueReusableCell(withIdentifier: self.endingPrayerCellIdentifier, for: indexPath) as? EndingPrayerTableViewCell
			cell?.initialize(spiritPrayer: self.endingPrayer.spirit, petitionPrayer: self.endingPrayer.petition, gracePrayer: self.endingPrayer.grace, praise1Prayer: self.endingPrayer.praise1, praise2Prayer: self.endingPrayer.praise2)
			return cell!
		default:
			return UITableViewCell()
		}
	}
	// For adjusting heights of cells based on the content
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
}

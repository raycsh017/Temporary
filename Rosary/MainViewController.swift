//
//  MainViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 12/29/16.
//  Copyright © 2016 sang. All rights reserved.
//

import UIKit
import SwiftyJSON
import JTAppleCalendar

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	// Static variables for drawing out views
	let LIGHT_GRAY = UIColor(colorLiteralRed: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
	let colorScheme = [
		UIColor.withRGB(red: 252, green: 177, blue: 122),
		UIColor.withRGB(red: 239, green: 132, blue: 100),
		UIColor.withRGB(red: 214, green: 73, blue: 90),
		UIColor.withRGB(red: 72, green: 73, blue: 137)
	]
	
	let cellSpacing: CGFloat = 20
	let numCellsInRow: CGFloat = 2
	
	let APP_TITLE: String = "54Days"
	
	@IBOutlet weak var rosaryMenuCollectionView: UICollectionView!{
		didSet{
			let flowLayout = UICollectionViewFlowLayout()
			flowLayout.minimumLineSpacing = self.cellSpacing
			flowLayout.minimumInteritemSpacing = self.cellSpacing
			
			self.rosaryMenuCollectionView.setCollectionViewLayout(flowLayout, animated: false)
			self.rosaryMenuCollectionView.backgroundColor = self.LIGHT_GRAY
			self.rosaryMenuCollectionView.clipsToBounds = false
		}
	}
//	@IBOutlet weak var otherPrayersView: UIView!{
//		didSet{
//			self.otherPrayersView.tag = 4
//			
//			self.otherPrayersView.clipsToBounds = false
//			self.otherPrayersView.addShadow()
//			
//			self.otherPrayersView.isUserInteractionEnabled = true
//			let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.touchedOtherPrayers(_:)))
//			self.otherPrayersView.addGestureRecognizer(tapRecognizer)
//		}
//	}
	
	// Static data
	let menus: [Menu] = [
		Menu(title: "환희의 신비", icon: UIImage(named: "ic_star")!, id: 0),
		Menu(title: "빛의 신비", icon: UIImage(named: "ic_fish")!, id: 1),
		Menu(title: "고통의 신비", icon: UIImage(named: "ic_crown_thorns")!, id: 2),
		Menu(title: "영광의 신비", icon: UIImage(named: "ic_cross")!, id: 3),
		Menu(title: "주요 기도문", icon: UIImage(named: "ic_pray")!, id: 4),
		Menu(title: "달력", icon: UIImage(named: "ic_calendar")!, id: 5)
	]
	
	let calendarSegueIdentifier = "displayCalendarSegue"
	let rosarySegueIdentifier = "displayRosaryPrayerSegue"
	let otherPrayersSegueIdentifier = "displayOtherPrayersSegue"
	
	// Dymanic data
	var rosaryStartingPrayers: [String: RosaryStartingPrayer] = [:]
	var rosaryEndingPrayer: RosaryEndingPrayer?
	var rosaryMysteries: [String: RosaryMystery] = [:]
	
	var otherPrayers: [Prayer] = []
	
	// For identifying which view was touched
	var selectedViewTag: Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.setup()
		self.loadInitialRosaryData()
		self.loadOtherPrayersData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func setup(){
		self.navigationItem.title = self.APP_TITLE
		self.view.backgroundColor = self.LIGHT_GRAY
		self.automaticallyAdjustsScrollViewInsets = false
		
		self.rosaryMenuCollectionView.dataSource = self
		self.rosaryMenuCollectionView.delegate = self
	}
	// Load initial rosary data from a local JSON file (rosaryData.json)
	func loadInitialRosaryData(){
		// Get the JSON data from rosaryData.json
		let path = Bundle.main.path(forResource: "rosaryData", ofType: "json")!
		let data = try! Data(contentsOf: URL(fileURLWithPath: path))
		let json = JSON(data: data)
		
		// Parse JSON and initialize var:rosaryStartingPrayer, rosaryMysteries, rosaryEndingPrayer
		// Starting part of Rosary prayer
		let startingPrayerSection = json["startingPrayers"]
		for(mysteryKey, startingPrayer) in startingPrayerSection{
			if let petition = startingPrayer["petition"].string, let grace = startingPrayer["grace"].string{
				self.rosaryStartingPrayers[mysteryKey] = RosaryStartingPrayer(petition: petition, grace: grace)
			}
		}
		
		// Main part of Rosary prayer
		let mysteriesSection = json["mysteries"]
		for (mysteryKey, mystery) in mysteriesSection{
			self.rosaryMysteries[mysteryKey] = RosaryMystery(title: mysteryKey, sections: [])
			for(_, mysterySection) in mystery{
				if let title = mysterySection["title"].string, let subText = mysterySection["subText"].string, let mainText = mysterySection["mainText"].string, let endingText = mysterySection["endingText"].string{
					let rosaryMysterySection = RosaryMysterySection(title: title, subText: subText, mainText: mainText, endingText: endingText)
					self.rosaryMysteries[mysteryKey]?.sections.append(rosaryMysterySection)
				}
			}
		}
		
		// Ending part of Rosary prayer
		let endingPrayerSection = json["endingPrayer"]
		if let spirit = endingPrayerSection["spirit"].string, let petition = endingPrayerSection["petition"].string, let grace = endingPrayerSection["grace"].string, let praise1 = endingPrayerSection["praise1"].array, let praise2 = endingPrayerSection["praise2"].string{
			let praise1Processed = praise1.map({$0.stringValue})
			self.rosaryEndingPrayer = RosaryEndingPrayer(spirit: spirit, petition: petition, grace: grace, praise1: praise1Processed, praise2: praise2)
		}
	}
	// Load other prayers data from a local JSON file (otherPrayersData.json)
	func loadOtherPrayersData(){
		let path = Bundle.main.path(forResource: "otherPrayersData", ofType: "json")!
		let data = try! Data(contentsOf: URL(fileURLWithPath: path))
		let json = JSON(data: data)
		
		// Parse JSON data from otherPrayersData.json
		for (_, prayer) in json{
			// Append every string in each prayer array into a string
			let prayerTitle = prayer["title"].stringValue
			let prayerText = NSMutableAttributedString()
			let prayerTextLines = prayer["text"].arrayValue
			for i in 0 ..< prayerTextLines.count{
				// Check a part of the prayer needs to be underlined
				// Underline it if necessary
				if let underlineAt = prayer["underlineAt"].int{
					if i == underlineAt{
						let originalString = prayerTextLines[underlineAt].stringValue
						let underlinedString = NSAttributedString(string: originalString, attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
						prayerText.append(underlinedString)
						continue
					}
				}
				let ordinaryString = NSAttributedString(string: prayerTextLines[i].stringValue)
				prayerText.append(ordinaryString)
			}
			self.otherPrayers.append(Prayer(title: prayerTitle, text: prayerText))
		}
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.menus.count
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let cvWidth = collectionView.bounds.width
		let cellWidth = (cvWidth - self.cellSpacing)/self.numCellsInRow
		
		return CGSize(width: cellWidth, height: cellWidth)
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RosaryMenuCollectionViewCell.cellID, for: indexPath) as? RosaryMenuCollectionViewCell
		let menu = self.menus[indexPath.row]
		
		cell?.initialize(title: menu.title, icon: menu.icon)
		cell?.addShadow()
		
		return cell!
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.selectedViewTag = indexPath.row
		switch indexPath.row{
		case 0...3:
			self.performSegue(withIdentifier: self.rosarySegueIdentifier, sender: self)
		case 4:
			self.performSegue(withIdentifier: self.otherPrayersSegueIdentifier, sender: self)
		case 5:
			self.performSegue(withIdentifier: self.calendarSegueIdentifier, sender: self)
		default:
			break
		}
	}
	
//	func touchedOtherPrayers(_ sender: UITapGestureRecognizer){
//		if let tag = sender.view?.tag{
//			self.selectedViewTag = tag
//			self.performSegue(withIdentifier: self.otherPrayersSegueIdentifier, sender: self)
//		}
//	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let identifier = segue.identifier{
			switch identifier{
			case self.rosarySegueIdentifier:
				let destinationVC = segue.destination as? RosaryPrayerViewController
				destinationVC?.endingPrayer = self.rosaryEndingPrayer
				switch self.selectedViewTag{
				case 0:
					destinationVC?.startingPrayer = self.rosaryStartingPrayers["환희의 신비"]
					destinationVC?.mystery = self.rosaryMysteries["환희의 신비"]
				case 1:
					destinationVC?.startingPrayer = self.rosaryStartingPrayers["빛의 신비"]
					destinationVC?.mystery = self.rosaryMysteries["빛의 신비"]
				case 2:
					destinationVC?.startingPrayer = self.rosaryStartingPrayers["고통의 신비"]
					destinationVC?.mystery = self.rosaryMysteries["고통의 신비"]
				case 3:
					destinationVC?.startingPrayer = self.rosaryStartingPrayers["영광의 신비"]
					destinationVC?.mystery = self.rosaryMysteries["영광의 신비"]
				default:
					break
				}
			case self.otherPrayersSegueIdentifier:
				let destinationVC = segue.destination as? OtherPrayersViewController
				destinationVC?.otherPrayers = self.otherPrayers
			case self.calendarSegueIdentifier:
				let destinationVC = segue.destination as? CalendarViewController
			default:
				break
			}
		}
	}
}

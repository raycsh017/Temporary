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
			
			self.rosaryMenuCollectionView.dataSource = self
			self.rosaryMenuCollectionView.delegate = self
		}
	}
	
	// Static data
	let menus: [Menu] = [
		Menu(title: "환희의 신비", icon: UIImage(named: "ic_star")!, id: 0),
		Menu(title: "빛의 신비", icon: UIImage(named: "ic_fish")!, id: 1),
		Menu(title: "고통의 신비", icon: UIImage(named: "ic_crown_thorns")!, id: 2),
		Menu(title: "영광의 신비", icon: UIImage(named: "ic_cross")!, id: 3),
		Menu(title: "주요 기도문", icon: UIImage(named: "ic_pray")!, id: 4),
		Menu(title: "달력", icon: UIImage(named: "ic_calendar")!, id: 5)
	]
	
	let calendarSegueIdentifier = "mainToCalendarSegue"
	let prayersSegueIdentifier = "mainToPrayersSegue"
	let rosarySegueIdentifier = "displayRosaryPrayerSegue"
	let otherPrayersSegueIdentifier = "displayOtherPrayersSegue"
	
	// Dymanic data
	var rosaryMysteries: [String: RosaryMystery] = [:]
	var rosaryEndingPrayer: RosaryEndingPrayer?
	
	var commonPrayers: [CommonPrayer] = []
	
	// For identifying which view was touched
	var selectedViewTag: Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.setup()
		self.loadRosaryPrayers()
		self.loadCommonPrayers()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func setup(){
		self.automaticallyAdjustsScrollViewInsets = false
	}
	// Load initial rosary data from a local JSON file (rosaryPrayers.json)
	func loadRosaryPrayers(){
		let path = Bundle.main.path(forResource: "rosaryPrayers", ofType: "json")!
		let data = try! Data(contentsOf: URL(fileURLWithPath: path))
		let json = JSON(data: data)
		
		// Parse JSON, Store into local variables
		for(key, mystery) in json["mysteries"]{
			let startingPrayer = mystery["startingPrayers"]
			let rosaryStartingPrayer = RosaryStartingPrayer(petition: startingPrayer["petition"].stringValue, grace: startingPrayer["grace"].stringValue)
			
			var mysterySections = [RosaryMysterySection]()
			for (_, section) in mystery["mainPrayers"]{
				let mysterySection = RosaryMysterySection(title: section["title"].stringValue, subText: section["subText"].stringValue, mainText: section["mainText"].stringValue, endingText: section["endingText"].stringValue)
				mysterySections.append(mysterySection)
			}
			
			let endingPrayer = mystery["endingPrayers"]
			let praise1Stringified = endingPrayer["praise1"].arrayValue.map({$0.stringValue})
			let rosaryEndingPrayer = RosaryEndingPrayer(spirit: endingPrayer["spirit"].stringValue, petition: endingPrayer["petition"].stringValue, grace: endingPrayer["grace"].stringValue, praise1: praise1Stringified, praise2: endingPrayer["praise2"].stringValue)
			
			let rosaryMystery = RosaryMystery(title: key, sections: mysterySections, startingPrayer: rosaryStartingPrayer, endingPrayer: rosaryEndingPrayer)
			self.rosaryMysteries[key] = rosaryMystery
		}

	}
	// Load other prayers data from a local JSON file (commonPrayers.json)
	func loadCommonPrayers(){
		let path = Bundle.main.path(forResource: "commonPrayers", ofType: "json")!
		let data = try! Data(contentsOf: URL(fileURLWithPath: path))
		let json = JSON(data: data)
		
		// Parse JSON data from commonPrayers.json
		for (_, prayer) in json{
			// Append every string in each prayer array into a string
			let prayerTitle = prayer["title"].stringValue
			let prayerText = NSMutableAttributedString()
			let prayerTextLines = prayer["text"].arrayValue
			for i in 0 ..< prayerTextLines.count{
				// Check if a part of the prayer needs to be underlined
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
			let prayerNumLines = prayerTextLines.count
			self.commonPrayers.append(CommonPrayer(title: prayerTitle, text: prayerText, numberOfLines: prayerNumLines))
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
		
		cell?.setValues(title: menu.title, icon: menu.icon)
		cell?.addShadow()
		
		return cell!
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.selectedViewTag = indexPath.row
		switch indexPath.row{
		case 0...4:
			self.performSegue(withIdentifier: self.prayersSegueIdentifier, sender: self)
		case 5:
			self.performSegue(withIdentifier: self.calendarSegueIdentifier, sender: self)
		default:
			break
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let identifier = segue.identifier{
			switch identifier{
			case self.prayersSegueIdentifier:
				let destVC = segue.destination as? PrayersViewController
				switch self.selectedViewTag{
				case 0:
					destVC?.rosaryPrayers = self.rosaryMysteries["환희의 신비"]
				case 1:
					destVC?.rosaryPrayers = self.rosaryMysteries["빛의 신비"]
				case 2:
					destVC?.rosaryPrayers = self.rosaryMysteries["고통의 신비"]
				case 3:
					destVC?.rosaryPrayers = self.rosaryMysteries["영광의 신비"]
				case 4:
					destVC?.commonPrayers = self.commonPrayers
				default:
					break
				}
			case self.calendarSegueIdentifier:
				let destVC = segue.destination as? CalendarViewController
			default:
				break
			}
		}
	}
}

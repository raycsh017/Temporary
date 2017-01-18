//
//  MainViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 12/29/16.
//  Copyright © 2016 sang. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainViewController: UIViewController {
	@IBOutlet weak var joyfulView: UIView!{
		didSet{
			self.joyfulView.tag = 0
			self.joyfulView.layer.borderColor = self.colorSchemes[0].cgColor
			self.joyfulView.layer.borderWidth = 2
			
			self.joyfulView.isUserInteractionEnabled = true
			let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.touchedViews(_:)))
			self.joyfulView.addGestureRecognizer(tapRecognizer)
		}
	}
	@IBOutlet weak var joyfulImageView: UIImageView!{
		didSet{
			self.joyfulImageView.image = UIImage(named: "Star")
		}
	}
	@IBOutlet weak var lightView: UIView!{
		didSet{
			self.lightView.tag = 1
			self.lightView.layer.borderColor = self.colorSchemes[1].cgColor
			self.lightView.layer.borderWidth = 2
			
			self.lightView.isUserInteractionEnabled = true
			let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.touchedViews(_:)))
			self.lightView.addGestureRecognizer(tapRecognizer)
		}
	}
	@IBOutlet weak var lightImageView: UIImageView!{
		didSet{
			self.lightImageView.image = UIImage(named: "Fish")
		}
	}
	@IBOutlet weak var sorrowfulView: UIView!{
		didSet{
			self.sorrowfulView.tag = 2
			self.sorrowfulView.layer.borderColor = self.colorSchemes[2].cgColor
			self.sorrowfulView.layer.borderWidth = 2
			
			self.sorrowfulView.isUserInteractionEnabled = true
			let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.touchedViews(_:)))
			self.sorrowfulView.addGestureRecognizer(tapRecognizer)
		}
	}
	@IBOutlet weak var sorrowfulImageView: UIImageView!{
		didSet{
			self.sorrowfulImageView.image = UIImage(named: "Crown")
		}
	}
	@IBOutlet weak var gloriousView: UIView!{
		didSet{
			self.gloriousView.tag = 3
			self.gloriousView.layer.borderColor = self.colorSchemes[3].cgColor
			self.gloriousView.layer.borderWidth = 2
			
			self.gloriousView.isUserInteractionEnabled = true
			let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.touchedViews(_:)))
			self.gloriousView.addGestureRecognizer(tapRecognizer)
		}
	}
	@IBOutlet weak var gloriousImageView: UIImageView!{
		didSet{
			self.gloriousImageView.image = UIImage(named: "Cross")
		}
	}
	@IBOutlet weak var otherPrayersView: UIView!{
		didSet{
			self.otherPrayersView.tag = 4
			self.otherPrayersView.layer.borderWidth = 2
			self.otherPrayersView.layer.borderColor = UIColor.black.cgColor
			
			self.otherPrayersView.isUserInteractionEnabled = true
			let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.touchedViews(_:)))
			self.otherPrayersView.addGestureRecognizer(tapRecognizer)
		}
	}
	
	var rosaryStartingPrayers: [String: RosaryStartingPrayer] = [:]
	var rosaryEndingPrayer: RosaryEndingPrayer?
	var rosaryMysteries: [String: RosaryMystery] = [:]
	
	var otherPrayers: [Prayer] = []
	
	var colorSchemes: [UIColor] = [
		UIColor.withRGB(red: 252, green: 177, blue: 122),
		UIColor.withRGB(red: 239, green: 132, blue: 100),
		UIColor.withRGB(red: 214, green: 73, blue: 90),
		UIColor.withRGB(red: 72, green: 73, blue: 137)
	]
	
	// For identifying which view was touched
	var selectedViewTag: Int = 0
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.loadInitialRosaryData()
		self.loadOtherPrayersData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationItem.title = "54일"
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
	
	func touchedViews(_ sender: UITapGestureRecognizer){
		if let selectedView = sender.view{
			self.selectedViewTag = selectedView.tag
			
			switch self.selectedViewTag{
			case 0..<4:
				self.performSegue(withIdentifier: "displayRosaryPrayerSegue", sender: self)
			case 4:
				self.performSegue(withIdentifier: "displayOtherPrayersSegue", sender: self)
			default:
				break
			}
		}
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "displayRosaryPrayerSegue"{
			// Transfer the Rosary data over to the PrayersViewController
			let destinationVC = segue.destination as? RosaryPrayerViewController
			
			destinationVC?.endingPrayer = self.rosaryEndingPrayer
			destinationVC?.selectedColor = self.colorSchemes[self.selectedViewTag]
			
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
			default: break
			}
		}
		else{
			let destinationVC = segue.destination as? OtherPrayersViewController
			destinationVC?.otherPrayers = self.otherPrayers
		}
	}
}

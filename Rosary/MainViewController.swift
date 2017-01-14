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
			self.joyfulView.layer.borderWidth = 2
			self.joyfulView.layer.borderColor = UIColor.withRGB(red: 252, green: 177, blue: 122).cgColor
			
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
			self.lightView.layer.borderWidth = 2
			self.lightView.layer.borderColor = UIColor.withRGB(red: 239, green: 132, blue: 100).cgColor
			
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
			self.sorrowfulView.layer.borderWidth = 2
			self.sorrowfulView.layer.borderColor = UIColor.withRGB(red: 214, green: 73, blue: 90).cgColor
			
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
			self.gloriousView.layer.borderWidth = 2
			self.gloriousView.layer.borderColor = UIColor.withRGB(red: 72, green: 73, blue: 137).cgColor
			
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
	
	var rosaryStartingPrayer: RosaryStartingPrayer?
	var rosaryMainPrayer: RosaryMainPrayer?
	var rosaryEndingPrayer: RosaryEndingPrayer?
	
	var otherPrayers: [Prayer] = []
	
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
	
	// Load initial rosary data from a local JSON file (rosaryData.json)
	func loadInitialRosaryData(){
		// Get the JSON data from rosaryData.json
		let path = Bundle.main.path(forResource: "rosaryData", ofType: "json")!
		let data = try! Data(contentsOf: URL(fileURLWithPath: path))
		let json = JSON(data: data)
		
		// Parse JSON and initialize var:rosaryStartingPrayer, rosaryMainPrayer, rosaryEndingPrayer
		// Starting part of Rosary prayer
		let startingPrayerSection = json["startingPrayer"]
		if let petition = startingPrayerSection["petition"].string, let grace = startingPrayerSection["grace"].string{
			self.rosaryStartingPrayer = RosaryStartingPrayer(petition: petition, grace: grace)
		}
		
		// Main part of Rosary prayer
		let mainPrayerSection = json["mainPrayer"]
		self.rosaryMainPrayer = RosaryMainPrayer(mysteries: [:])
		for (mysteryKey, mystery) in mainPrayerSection{
			self.rosaryMainPrayer?.mysteries[mysteryKey] = []
			for(_, mysterySection) in mystery{
				if let title = mysterySection["title"].string, let subText = mysterySection["subText"].string, let mainText = mysterySection["mainText"].string, let endingText = mysterySection["endingText"].string{
					let rosaryMysterySection = RosaryMysterySection(title: title, subText: subText, mainText: mainText, endingText: endingText)
					self.rosaryMainPrayer?.mysteries[mysteryKey]?.append(rosaryMysterySection)
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
			
			destinationVC?.startingPrayer = self.rosaryStartingPrayer
			destinationVC?.endingPrayer = self.rosaryEndingPrayer
			
			switch self.selectedViewTag{
			case 0:
				destinationVC?.mystery = "환희의 신비"
				destinationVC?.mysterySections = self.rosaryMainPrayer?.mysteries["joyful"]
			case 1:
				destinationVC?.mystery = "빛의 신비"
				destinationVC?.mysterySections = self.rosaryMainPrayer?.mysteries["light"]
			case 2:
				destinationVC?.mystery = "고통의 신비"
				destinationVC?.mysterySections = self.rosaryMainPrayer?.mysteries["sorrowful"]
			case 3:
				destinationVC?.mystery = "영광의 신비"
				destinationVC?.mysterySections = self.rosaryMainPrayer?.mysteries["glorious"]
			default: break
			}
		}
		else{
			let destinationVC = segue.destination as? OtherPrayersViewController
			
			destinationVC?.otherPrayers = self.otherPrayers
		}
	}
}

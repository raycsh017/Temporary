//
//  MainViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 12/29/16.
//  Copyright © 2016 sang. All rights reserved.
//

import UIKit
import SwiftyJSON

struct MainTitle{
	let title: String
	let color: UIColor
	let icon: UIImage
}

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
	
	var rosaryStarting: RosaryStartingPrayer?
	var rosaryMain: RosaryMainPrayer?
	var rosaryEnding: RosaryEndingPrayer?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.loadInitialRosaryData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func loadInitialRosaryData(){
		// Get static data from a local JSON file (rosaryData.json)
		let path = Bundle.main.path(forResource: "rosaryData", ofType: "json")!
		let data = try! Data(contentsOf: URL(fileURLWithPath: path))
		let json = JSON(data: data)
		
		
		// Parse JSON and initialize var:rosaryStarting, rosaryMain, rosaryEnding
		// Starting part of Rosary prayer
		let startingPrayerSection = json["startingPrayer"]
		if let petition = startingPrayerSection["petition"].string, let grace = startingPrayerSection["grace"].string{
			self.rosaryStarting = RosaryStartingPrayer(petition: petition, grace: grace)
		}
//		print(self.rosaryStarting)
		
		// Main part of Rosary prayer
		let mainPrayerSection = json["mainPrayer"]
		self.rosaryMain = RosaryMainPrayer(mysteries: [:])
		for (mysteryKey, mystery) in mainPrayerSection{
			self.rosaryMain?.mysteries[mysteryKey] = []
			for(_, mysterySection) in mystery{
				if let title = mysterySection["title"].string, let subText = mysterySection["subText"].string, let mainText = mysterySection["mainText"].string, let endingText = mysterySection["endingText"].string{
					let rosaryMysterySection = RosaryMysterySection(title: title, subText: subText, mainText: mainText, endingText: endingText)
					self.rosaryMain?.mysteries[mysteryKey]?.append(rosaryMysterySection)
				}
			}
		}
//		print(self.rosaryMain?.mysteries)
		
		// Ending part of Rosary prayer
		let endingPrayerSection = json["endingPrayer"]
		if let spirit = endingPrayerSection["spirit"].string, let petition = endingPrayerSection["petition"].string, let grace = endingPrayerSection["grace"].string, let praise1 = endingPrayerSection["praise1"].string, let praise2 = endingPrayerSection["praise2"].string{
			self.rosaryEnding = RosaryEndingPrayer(spirit: spirit, petition: petition, grace: grace, praise1: praise1, praise2: praise2)
		}
//		print(self.rosaryEnding)
	}
	func touchedViews(_ sender: UITapGestureRecognizer){
		print(sender.view?.tag)
	}
	
}

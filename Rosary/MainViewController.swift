//
//  MainViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 12/29/16.
//  Copyright © 2016 sang. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	// Static variables for drawing out views
	let numCellsInRow: CGFloat = 2
	
	let APP_TITLE: String = "54Days"
	
	let menuCellSpacing: CGFloat = 16.0
	
	@IBOutlet weak var miniCalendarView: UIView!
	@IBOutlet weak var miniCalendarDayLabel: UILabel!{
		didSet{
			self.dateFormatter.dateFormat = "dd"
			self.miniCalendarDayLabel.text = self.dateFormatter.string(from: self.currentDate)
		}
	}
	@IBOutlet weak var miniCalendarMonthLabel: UILabel!{
		didSet{
			self.dateFormatter.dateFormat = "MMM"
			self.miniCalendarMonthLabel.text = self.dateFormatter.string(from: self.currentDate)
		}
	}
	@IBOutlet weak var miniCalendarDescriptionLabel: UILabel!
	
	@IBOutlet weak var rosaryMenuContainerView: UIView!{
		didSet{
			self.rosaryMenuContainerView.backgroundColor = FiftyFour.color.lightGray
			self.rosaryMenuContainerView.clipsToBounds = true
		}
	}
	@IBOutlet weak var rosaryMenuCollectionView: UICollectionView!{
		didSet{
			let flowLayout = UICollectionViewFlowLayout()
			flowLayout.minimumLineSpacing = self.menuCellSpacing
			flowLayout.minimumInteritemSpacing = self.menuCellSpacing
			
			self.rosaryMenuCollectionView.setCollectionViewLayout(flowLayout, animated: false)
			self.rosaryMenuCollectionView.backgroundColor = FiftyFour.color.lightGray
			self.rosaryMenuCollectionView.clipsToBounds = false
			self.rosaryMenuCollectionView.showsVerticalScrollIndicator = false
			
			self.rosaryMenuCollectionView.dataSource = self
			self.rosaryMenuCollectionView.delegate = self
		}
	}
	@IBOutlet weak var creditsView: UIView!{
		didSet{
			let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.openCreditsModal))
			self.creditsView.addGestureRecognizer(gestureRecognizer)
		}
	}
	
	// Static data
	let menus = MainMenu.all
	
	let calendarSegueIdentifier = "mainToCalendarSegue"
	let prayersSegueIdentifier = "mainToPrayersSegue"
	let rosarySegueIdentifier = "displayRosaryPrayerSegue"
	
	let calendar = Calendar.current
	let dateFormatter = DateFormatter()
	let currentDate = Date()
	let realm = try! Realm()
	
	// Dymanic data
	var rosaryMysteries: [String: RosaryMystery] = [:]
	var rosaryEndingPrayer: RosaryEndingPrayer?
	
	var commonPrayers: [CommonPrayer] = []
	var rosaryPeriod: RosaryPeriod?
	
	// For identifying which view was touched
	var selectedIndexPath: IndexPath?
	
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
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.miniCalendarView.addShadow()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.updateMiniCalendar()
	}
	
	func updateMiniCalendar(){
		let rosaryPeriods = realm.objects(RosaryPeriod.self)
		if let rosaryStartDate = rosaryPeriods.first?.startDate{
			// Calculate the number of days passed from the StartDate to today's date
			let date1 = self.calendar.startOfDay(for: rosaryStartDate)
			let date2 = self.calendar.startOfDay(for: self.currentDate)
			let numDaysFromStartDate = self.calendar.dateComponents([.day], from: date1, to: date2).day!
			
			// If the user is in the middle of Rosary Period, update the miniCalendarView
			if 0 <= numDaysFromStartDate && numDaysFromStartDate < 54{
				let boldStringAttr = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0)]
				let numDaysPassedString = NSAttributedString(string: "\(numDaysFromStartDate + 1)일", attributes: boldStringAttr)
				
				let colorIndex = (numDaysFromStartDate < 27) ? (numDaysFromStartDate % 4) : ((numDaysFromStartDate+1) % 4)
				let color = RosaryColor(rawValue: colorIndex)!
				let coloredStringAttr = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0), NSForegroundColorAttributeName: color.uiColor]
				let coloredStringValue = RosaryMysteryType(rawValue: colorIndex)!.inKorean
				let rosaryForTodayString = NSAttributedString(string: "\(coloredStringValue)", attributes: coloredStringAttr)
				
				let newCalendarDescription = NSMutableAttributedString()
				newCalendarDescription.append(NSAttributedString(string: "오늘은 묵주기도 "))
				newCalendarDescription.append(numDaysPassedString)
				newCalendarDescription.append(NSAttributedString(string: "째이며, "))
				newCalendarDescription.append(rosaryForTodayString)
				
				// Account for 27th, 54th day of Rosary
				if numDaysFromStartDate == 26 || numDaysFromStartDate == 53{
					let additionalColor = RosaryColor.darkSlateBlue
					let additionalColorStringAttr = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0), NSForegroundColorAttributeName: additionalColor.uiColor]
					let additionalStringValue = RosaryMysteryType.glorious.inKorean
					let rosaryForTodayString = NSAttributedString(string: "\(additionalStringValue)", attributes: additionalColorStringAttr)
					newCalendarDescription.append(NSAttributedString(string: ", "))
					newCalendarDescription.append(rosaryForTodayString)
				}
				
				newCalendarDescription.append(NSAttributedString(string: "를 하실 차례입니다 :)"))
				
				self.miniCalendarDescriptionLabel.attributedText = newCalendarDescription
			}
			else{
				self.miniCalendarDescriptionLabel.text = "묵주기도를 하시는 중이 아닌가봐요 >:("
			}
		}
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
			
			let rosaryMystery = RosaryMystery(type: RosaryMysteryType(rawString: key)!, sections: mysterySections, startingPrayer: rosaryStartingPrayer, endingPrayer: rosaryEndingPrayer)
			self.rosaryMysteries[key] = rosaryMystery
		}

	}
	// Load common prayers data from a local JSON file (commonPrayers.json)
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
		let cellWidth = (cvWidth - self.menuCellSpacing)/self.numCellsInRow
		
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
		self.selectedIndexPath = indexPath
		switch indexPath.row{
		case 0...4:
			self.performSegue(withIdentifier: self.prayersSegueIdentifier, sender: self)
		case 5:
			self.performSegue(withIdentifier: self.calendarSegueIdentifier, sender: self)
		default:
			break
		}
	}
	
	func openCreditsModal(gestureRecognizer: UITapGestureRecognizer){
		let creditsModalVC = self.storyboard?.instantiateViewController(withIdentifier: "CreditsModalViewController") as? CreditsModalViewController
		creditsModalVC?.modalPresentationStyle = .overCurrentContext
		self.present(creditsModalVC!, animated: false, completion: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let selectedMenu = self.selectedIndexPath?.row else{
			return
		}
		
		if let identifier = segue.identifier{
			segue.destination.navigationItem.title = MainMenu(rawValue: selectedMenu)?.title
			
			switch identifier{
			case self.prayersSegueIdentifier:
				let destVC = segue.destination as? PrayersViewController
				switch selectedMenu{
				case 0...3:
					let rosaryMystery = RosaryMysteryType(rawValue: selectedMenu)!.inEnglish
					destVC?.rosaryPrayers = self.rosaryMysteries[rosaryMystery]
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

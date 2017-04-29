//
//  PrayersMenuViewModel.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 3/30/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift



class PrayersListViewModel{
	
	// MARK: - Static Variables
	let prayerTypes = PrayerType.all
	
	let rosaryMysteriesList = RosaryMysteryType.all
	let generalPrayersList = GeneralPrayerType.all
	
	let calendar = Calendar.current
	let currentDate = Date()
	
	let realm = try! Realm()
	
	// MARK: - Dynamic Variables
	var rosaryPrayers: [String: RosaryPrayer] = [:]
	var generalPrayers: [GeneralPrayer] = []
	
	var rosaryPeriod: RosaryPeriod?
	
	// MARK: - Functions
	func setup(){
		// Get Rosary data from rosaryPrayers.json
		let rosaryPrayersData = self.loadLocalData(from: "rosaryPrayers")
		self.rosaryPrayers = self.parseRosaryPrayers(fromJSON: rosaryPrayersData)
		
		// Get Prayer data from prayers.json
		let generalPrayersData = self.loadLocalData(from: "prayers")
		self.generalPrayers = self.parsePrayers(fromJSON: generalPrayersData)
	}
	
	func loadLocalData(from resourceName: String) -> Data?{
		// Retreive JSON data from a local file
		let path = Bundle.main.path(forResource: resourceName, ofType: "json")!
		let data = try? Data(contentsOf: URL(fileURLWithPath: path))
		return data
	}
	
	func parseRosaryPrayers(fromJSON data: Data?) -> [String: RosaryPrayer]{
		guard let data = data else{
			return [:]
		}
		
		let json = JSON(data: data)
		var rosaryPrayers: [String: RosaryPrayer] = [:]
		
		for(key, mystery) in json["mysteries"]{
			// Parse the starting portion of a Rosary Mystery
			let startingPrayer = mystery["startingPrayers"]
			let rosaryStartingPrayer = RosaryStartingPrayer(petition: startingPrayer["petition"].stringValue, grace: startingPrayer["grace"].stringValue)
			
			// Parse the main portion of a Rosary Mystery
			let type = RosaryMysteryType(rawString: key)
			let rosaryMystery = RosaryMystery(type: type!)
			for (_, section) in mystery["mainPrayers"]{
				if let title = section["title"].string, let subText = section["subText"].string, let mainText = section["mainText"].string, let endingText = section["endingText"].string{
					rosaryMystery.addSection(title: title, subText: subText, mainText: mainText, endingText: endingText)
				}
			}
			
			// Parse the ending portion of a Rosary Mystery
			let endingPrayer = mystery["endingPrayers"]
			let praise1Stringified = endingPrayer["praise1"].arrayValue.map({$0.stringValue})
			let rosaryEndingPrayer = RosaryEndingPrayer(spirit: endingPrayer["spirit"].stringValue, petition: endingPrayer["petition"].stringValue, grace: endingPrayer["grace"].stringValue, praise1: praise1Stringified, praise2: endingPrayer["praise2"].stringValue)
			
			// Combine what's parsed and save it in one data structure
			let rosaryPrayer = RosaryPrayer(mystery: rosaryMystery, startingPrayer: rosaryStartingPrayer, endingPrayer: rosaryEndingPrayer)
			rosaryPrayers[key] = rosaryPrayer
		}
		
		return rosaryPrayers
	}

	func parsePrayers(fromJSON data: Data?) -> [GeneralPrayer]{
		guard let data = data else{
			return []
		}
		
		let json = JSON(data: data)
		var prayers: [GeneralPrayer] = []
		
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
			
			let prayer = GeneralPrayer(title: prayerTitle, text: prayerText, numberOfLines: prayerNumLines)
			prayers.append(prayer)
		}
		
		return prayers
	}
	
	func findMysteryForToday(errorHandler: ()->(), completionHandler: (NSAttributedString)->())
		{
		// Check if Rosary Period is set
		let rosaryPeriods = realm.objects(RosaryPeriod.self)
		guard let rosaryStartDate = rosaryPeriods.first?.startDate else{
			errorHandler()
			return
		}
		
		// Calculate the number of days passed from the StartDate to today's date
		let date1 = self.calendar.startOfDay(for: rosaryStartDate)
		let date2 = self.calendar.startOfDay(for: self.currentDate)
		let numDaysFromStartDate = self.calendar.dateComponents([.day], from: date1, to: date2).day!
		
		// Check if today is in the middle of Rosary Period
		guard 0 <= numDaysFromStartDate && numDaysFromStartDate < 54 else{
			errorHandler()
			return
		}
		
		// Add attributes to substrings
		let boldStringAttr = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0)]
		let underlineStringAttr = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
		let numDaysPassedString = NSAttributedString(string: "\(numDaysFromStartDate + 1)일", attributes: boldStringAttr)
		
		let newCalendarDescription = NSMutableAttributedString()
		
		newCalendarDescription.append(NSAttributedString(string: "오늘은 묵주기도 "))
		newCalendarDescription.append(numDaysPassedString)
		newCalendarDescription.append(NSAttributedString(string: "째이며, "))
		
		// 1~27 petition prayer period, 28~54 grace prayer period
		switch numDaysFromStartDate{
		case 0...26:
			let petitionPrayerString = NSAttributedString(string: "청원기도", attributes: underlineStringAttr)
			newCalendarDescription.append(petitionPrayerString)
			newCalendarDescription.append(NSAttributedString(string: ", "))
		case 27...53:
			let gracePrayerString = NSAttributedString(string: "감사기도", attributes: underlineStringAttr)
			newCalendarDescription.append(gracePrayerString)
			newCalendarDescription.append(NSAttributedString(string: ", "))
		default:
			break
		}
		
		// Determine which mystery the user has to do for the current date
		let colorIndex = (numDaysFromStartDate < 27) ? (numDaysFromStartDate % 4) : ((numDaysFromStartDate+1) % 4)
		let color = RosaryColor(rawValue: colorIndex)!
		let coloredStringAttr = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0), NSForegroundColorAttributeName: color.uiColor]
		let coloredStringValue = RosaryMysteryType(rawValue: colorIndex)!.inKorean
		let rosaryForTodayString = NSAttributedString(string: "\(coloredStringValue)", attributes: coloredStringAttr)
		newCalendarDescription.append(rosaryForTodayString)
			
		// Account for 27th, 54th days of Rosary
		if numDaysFromStartDate == 26 || numDaysFromStartDate == 53{
			let additionalColor = RosaryColor.darkSlateBlue
			let additionalColorStringAttr = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0), NSForegroundColorAttributeName: additionalColor.uiColor]
			let additionalStringValue = RosaryMysteryType.glorious.inKorean
			let rosaryForTodayString = NSAttributedString(string: "\(additionalStringValue)", attributes: additionalColorStringAttr)
			newCalendarDescription.append(NSAttributedString(string: ", "))
			newCalendarDescription.append(rosaryForTodayString)
		}
		newCalendarDescription.append(NSAttributedString(string: "를 하실 차례입니다 :)"))
			
		completionHandler(newCalendarDescription)
	}
}

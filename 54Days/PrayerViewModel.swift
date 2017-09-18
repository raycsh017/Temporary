import Foundation
import UIKit
import SwiftyJSON

class PrayerViewModel {
	// MARK: Static
	private let kOtherPrayersJsonFileName = "prayers"
	private let kRosaryPrayersJsonFileName = "rosaryPrayers"
	
	let fileUtility = FileUtility()
	
	// MARK: Dynamic
	var rosaryPrayers: [String: RosaryPrayer] = [:]
	var otherPrayers: [OtherPrayer] = []
	
	init() {
		let rosaryPrayersData = fileUtility.loadData(fromJSONFileWithName: kRosaryPrayersJsonFileName)
		parseRosaryPrayers(fromJSON: rosaryPrayersData)
		
		let otherPrayersData = fileUtility.loadData(fromJSONFileWithName: kOtherPrayersJsonFileName)
		parseOtherPrayers(fromJSON: otherPrayersData)
	}
	
	private func parseRosaryPrayers(fromJSON data: Data?) {
		guard let data = data else{
			return
		}
		
		let json = JSON(data: data)
		var rosaryPrayers: [String: RosaryPrayer] = [:]
		
		for(key, mystery) in json["mysteries"]{
			// Parse the starting portion of a Rosary Mystery
			let startingPrayers = mystery["startingPrayers"]
			guard let petition = startingPrayers["petition"].string, let grace = startingPrayers["grace"].string else {
				break
			}
			let rosaryStartingPrayer = RosaryStartingPrayer(petition: petition, grace: grace)
			
			// Parse the main portion of a Rosary Mystery
			let rosaryMysterySections = mystery["mainPrayers"].flatMap {
				(_, section) -> RosaryMystery.Section? in
				if let title = section["title"].string, let subText = section["subText"].string, let mainText = section["mainText"].string, let endingText = section["endingText"].string {
					return RosaryMystery.Section(title: title, subText: subText, mainText: mainText, endingText: endingText)
				} else {
					return nil
				}
			}
			guard let rosaryMysteryType = RosaryMysteryType(rawValue: key), !rosaryMysterySections.isEmpty else {
				break
			}
			let rosaryMystery = RosaryMystery(type: rosaryMysteryType, sections: rosaryMysterySections)
			
			// Parse the ending portion of a Rosary Mystery
			let endingPrayers = mystery["endingPrayers"]
			guard let spirit = endingPrayers["spirit"].string,
				let epPetition = endingPrayers["petition"].string,
				let epGrace = endingPrayers["grace"].string,
				let praise1 = endingPrayers["praise1"].array,
				let praise2 = endingPrayers["praise2"].string else {
					break
			}
			let praise1StringParsed = praise1.flatMap{ $0.string }
			let rosaryEndingPrayer = RosaryEndingPrayer(spirit: spirit, petition: epPetition, grace: epGrace, praise1: praise1StringParsed, praise2: praise2)
			
			// Combine what's parsed and save it in one data structure
			let rosaryPrayer = RosaryPrayer(mystery: rosaryMystery, startingPrayer: rosaryStartingPrayer, endingPrayer: rosaryEndingPrayer)
			rosaryPrayers[key] = rosaryPrayer
		}
	}
	
	private func parseOtherPrayers(fromJSON data: Data?){
		guard let data = data else{
			return
		}
		
		let json = JSON(data: data)
		var prayers: [OtherPrayer] = []
		
		for (_, prayer) in json{
			guard let prayerTitle = prayer["title"].string, let prayerTextLines = prayer["text"].array else {
				break
			}
			let prayerText = NSMutableAttributedString()
			
			for i in 0..<prayerTextLines.count {
				if let underlineAt = prayer["underlineAt"].int, i == underlineAt,
					let prayerTextLine = prayerTextLines[underlineAt].string {
					let underlinedTextLine = NSAttributedString(string: prayerTextLine, attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle])
					prayerText.append(underlinedTextLine)
				} else {
					if let prayerTextLine = prayerTextLines[i].string {
						let ordinaryString = NSAttributedString(string: prayerTextLine)
						prayerText.append(ordinaryString)
					}
				}
			}
			
			let prayerNumLines = prayerTextLines.count
			
			let prayer = OtherPrayer(title: prayerTitle, text: prayerText, numberOfLines: prayerNumLines)
			prayers.append(prayer)
		}
		
		otherPrayers = prayers
	}

}

import Foundation
import UIKit
import SwiftyJSON

class PrayerViewModel {
	typealias RosaryMysteryKey = String
	
	private let kOtherPrayersJsonFileName = "prayers"
	private let kRosaryPrayersJsonFileName = "rosaryPrayers"
	
	let prayerType: PrayerType
	
	var rosaryPrayer = [RosaryMysteryKey: RosaryMystery]()
	var otherPrayers = [OtherPrayer]()
	
	init(prayerType: PrayerType) {
		self.prayerType = prayerType
		
		switch prayerType {
		case .rosary:
			loadRosaryPrayers()
		case .other:
			loadOtherPrayers()
		}
	}
	
	// MARK: Cell Configuration
	func cellConfigurators() -> [CellConfiguratorType] {
		var cellConfigurators = [CellConfiguratorType]()
		
		switch prayerType {
		case .rosary(let mysteryType):
			guard let rosaryMystery = rosaryPrayer[mysteryType.key] else {
				break
			}
			
			let startingPrayer = rosaryMystery.startingPrayer
			let startingPrayerCellConfigurator = TableCellConfigurator<RosaryStartingPrayerTableViewCell>(cellData: RosaryStartingPrayerTableCellData(petitionPrayer: startingPrayer.petition, gracePrayer: startingPrayer.grace))
			
			let subMysteryPrayers = rosaryMystery.subMysteryPrayers
			let subMysteryCellConfigurators = subMysteryPrayers
				.map { RosarySubMysteryTableCellData(title: $0.title, subTitle: $0.subText, mainText: $0.mainText, endingText: $0.endingText) }
				.map { TableCellConfigurator<RosarySubMysteryTableViewCell>(cellData: $0) as CellConfiguratorType }

			let finishingPrayer = rosaryMystery.finishingPrayer
			let praise1BulletsApplied = applyAlternatingBulletsToTextLines(finishingPrayer.praise1)
			let praise1Prayer = combine(praise1BulletsApplied)
			let finishingPrayerCellConfigurator = TableCellConfigurator<RosaryFinishingPrayerTableViewCell>(cellData: RosaryFinishingPrayerTableCellData(spiritPrayer: finishingPrayer.spirit, petitionPrayer: finishingPrayer.petition, gracePrayer: finishingPrayer.grace, praiseFirstPart: praise1Prayer, praiseSecondPart: finishingPrayer.praise2))

			cellConfigurators.append(startingPrayerCellConfigurator)
			cellConfigurators.append(contentsOf: subMysteryCellConfigurators)
			cellConfigurators.append(finishingPrayerCellConfigurator)
			
		case .other:
			var otherPrayerCellConfigurators: [CellConfiguratorType] = []
			otherPrayerCellConfigurators = otherPrayers.map {
				let prayerLinesUnderlined = combine(applyUnderlineOnPrayerLines($0.textLines, at: $0.underlineLineOffset))
				return OtherPrayerTableCellData(title: $0.title, body: prayerLinesUnderlined)
			}.map {
				return TableCellConfigurator<OtherPrayerTableViewCell>(cellData: $0) as CellConfiguratorType
			}
			
			cellConfigurators.append(contentsOf: otherPrayerCellConfigurators)
		}
		
		return cellConfigurators
	}
	
	// MARK: Load Data
	private func loadRosaryPrayers() {
		let rosaryPrayersData = FileUtility.loadData(fromJSONFileWithName: kRosaryPrayersJsonFileName)
		rosaryPrayer = parseRosaryPrayers(fromJSON: rosaryPrayersData)
	}
	
	private func parseRosaryPrayers(fromJSON data: Data?) -> [RosaryMysteryKey: RosaryMystery] {
		guard let data = data else{
			return [:]
		}
		
		let json = JSON(data: data)
		var rosaryPrayer = [RosaryMysteryKey: RosaryMystery]()
		
		for(key, mystery) in json["mysteries"]{
			// Parse the mystery type
			guard let rosaryMysteryType = RosaryMystery.MysteryType(rawValue: key) else {
				break
			}
			
			// Parse the starting portion of a Rosary Mystery
			let startingPrayer = mystery["startingPrayer"]
			guard let petition = startingPrayer["petition"].string, let grace = startingPrayer["grace"].string else {
				break
			}
			let rosaryStartingPrayers = RosaryMystery.StartingPrayer(petition: petition, grace: grace)
			
			// Parse the subMystery portion of a Rosary Mystery
			let rosarySubMysteries = mystery["subMysteries"].flatMap {
				(_, subMystery) -> RosaryMystery.SubMysteryPrayer? in
				if let title = subMystery["title"].string,
					let subText = subMystery["subText"].string,
					let mainText = subMystery["mainText"].string,
					let endingText = subMystery["endingText"].string {
					return RosaryMystery.SubMysteryPrayer(title: title, subText: subText, mainText: mainText, endingText: endingText)
				} else {
					return nil
				}
			}
			
			// Parse the ending portion of a Rosary Mystery
			let finishingPrayer = mystery["finishingPrayer"]
			guard let spirit = finishingPrayer["spirit"].string,
				let petitionPrayer = finishingPrayer["petition"].string,
				let gracePrayer = finishingPrayer["grace"].string,
				let praiseFirstPartArray = finishingPrayer["praise1"].array,
				let praiseSecondPart = finishingPrayer["praise2"].string else {
					break
			}
			let parsedPraiseFirstPart = praiseFirstPartArray.flatMap{ $0.string }
			let rosaryfinishingPrayer = RosaryMystery.FinishingPrayer(spirit: spirit, petition: petitionPrayer, grace: gracePrayer, praise1: parsedPraiseFirstPart, praise2: praiseSecondPart)
			
			// Combine what's parsed and save it in one data structure
			let rosaryMystery = RosaryMystery(type: rosaryMysteryType, startingPrayer: rosaryStartingPrayers, subMysteryPrayers: rosarySubMysteries, finishingPrayer: rosaryfinishingPrayer)
			rosaryPrayer[key] = rosaryMystery
		}
		
		return rosaryPrayer
	}
	
	private func loadOtherPrayers() {
		let otherPrayersData = FileUtility.loadData(fromJSONFileWithName: kOtherPrayersJsonFileName)
		otherPrayers = parseOtherPrayers(fromJSON: otherPrayersData)
	}
	
	private func parseOtherPrayers(fromJSON data: Data?) -> [OtherPrayer] {
		guard let data = data else{
			return []
		}
		
		let json = JSON(data: data)
		var otherPrayers: [OtherPrayer] = []
		
		for (_, prayer) in json{
			guard let prayerTitle = prayer["title"].string,
				let prayerTextArray = prayer["text"].array else {
				break
			}
			
			let prayerTextLines = prayerTextArray.flatMap { $0.string }
			let prayerUnderlinedLineOffset = prayer["underlineLineOffset"].int
			
			let otherPrayer = OtherPrayer(title: prayerTitle, textLines: prayerTextLines, underlineLineOffset: prayerUnderlinedLineOffset)
			otherPrayers.append(otherPrayer)
		}
		
		return otherPrayers
	}

	// MARK: Style Models
	private func applyAlternatingBulletsToTextLines(_ textLines: [String]) -> [String] {
		return textLines.enumerated().map { (offset, string) -> String in
					if offset % 2 == 0 {
						return Unicode.WhiteBullet + " \(string)"
					} else {
						return Unicode.Bullet + " \(string)"
					}
				}
	}
	
	private func combine(_ textLines: [String]) -> String {
		return textLines.reduce("") { $0 + $1 }
	}
	
	private func combine(_ attributedTextLines: [NSAttributedString]) -> NSAttributedString {
		var mutableAttributedString = NSMutableAttributedString()
		attributedTextLines.forEach { mutableAttributedString.append($0) }
		return mutableAttributedString as NSAttributedString
	}
	
	private func applyUnderlineOnPrayerLines(_ textLines: [String], at lineOffset: Int?) -> [NSAttributedString] {
		return textLines.enumerated().map {
			if let lineOffset = lineOffset,
				$0.offset == lineOffset {
				return NSAttributedString(string: $0.element, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
			} else {
				return NSAttributedString(string: $0.element)
			}
		}
	}
}

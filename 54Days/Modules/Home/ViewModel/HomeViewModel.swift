import UIKit
import SwiftyJSON
import Realm
import RealmSwift

class HomeViewModel {
	fileprivate let rosaryProgressInfoPlaceholder: String = "현재 진행중인 묵주기도가 없습니다 😕"
	
	fileprivate let dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMMM dd"
		return dateFormatter
	}()
	
	fileprivate var realm: Realm?
	
	fileprivate let prayerTypes = PrayerType.all
	fileprivate let mysteryTypes = RosaryMystery.MysteryType.all
	
	var recentRosaryRecord: RosaryRecord? {
		return realm?.objects(RosaryRecord.self).first ?? nil
	}
	
	fileprivate var todayDateFormatted: String {
		return dateFormatter.string(from: Date())
	}
	
	init() {
		initializeRealm()
	}
	
	private func initializeRealm() {
		do {
			realm = try Realm()
		} catch let error as NSError {
			print(error)
		}
	}
}

extension HomeViewModel {
	func cellConfigurators() -> [CellConfiguratorType] {
		var cellConfigurators = [CellConfiguratorType]()
		
		cellConfigurators.append(prayerInfoCellConfigurator())
		cellConfigurators.append(contentsOf: prayerEntryCellConfigurators())
		
		return cellConfigurators
	}
	
	private func prayerInfoCellConfigurator() -> CellConfiguratorType {
		let (progressDescription, numberOfDaysPassed) = currentRosaryInformation()
		let currentRosaryInfoCellData = HomeCurrentRosaryInfoCellData(todaysDateText: todayDateFormatted, progressDescription: progressDescription, numberOfDaysPassed: numberOfDaysPassed)
		return TableCellConfigurator<HomeCurrentRosaryInfoTableViewCell>(cellData: currentRosaryInfoCellData) as CellConfiguratorType
	}
	
	private func prayerEntryCellConfigurators() -> [CellConfiguratorType] {
		let prayerEntryCellData = prayerTypes.map { HomePrayerEntryCellData(prayerType: $0) }
		let prayerEntryCellConfigurators = prayerEntryCellData.map { TableCellConfigurator<HomePrayerEntryTableViewCell>(cellData: $0) as CellConfiguratorType }
		return prayerEntryCellConfigurators
	}
}

// Current prayer information
extension HomeViewModel {
	typealias CurrentRosaryInfo = (progressDescription: NSAttributedString, numberOfDaysPassed: Int)
	
	fileprivate func currentRosaryInformation() -> CurrentRosaryInfo {
		guard let recentRosaryRecord = recentRosaryRecord else {
			return (NSAttributedString(string: rosaryProgressInfoPlaceholder), 0)
		}
		
		let startDate = recentRosaryRecord.startDate
		
		let startOfStartDate = Calendar.current.startOfDay(for: startDate)
		let startOfCurrentDate = Calendar.current.startOfDay(for: Date())
		let diffBetweenTwoDates = Calendar.current.dateComponents([.day], from: startOfStartDate, to: startOfCurrentDate)
		
		guard let numDaysFromStartDate = diffBetweenTwoDates.day,
			0 <= numDaysFromStartDate &&
			numDaysFromStartDate < RosaryConstants.numberOfDaysInPeriod else {
			return (NSAttributedString(string: rosaryProgressInfoPlaceholder), 0)
		}
		
		// x일
		let numDaysPassedString = "\(numDaysFromStartDate + 1)일"
		let numDaysPassedAttributedString = NSAttributedString(string: numDaysPassedString, attributes: [
			.font: Font.bf16
		])
		
		// xx기도
		var rosaryTypeString = ""
		switch numDaysFromStartDate {
		case RosaryConstants.petitionPeriod:
			rosaryTypeString = "청원기도"
		case RosaryConstants.gracePeriod:
			rosaryTypeString = "감사기도"
		default:
			break
		}
		
		let rosaryTypeAttributedString = NSAttributedString(string: rosaryTypeString, attributes: [
			.font: Font.bf16
		])
		
		// xx의 신비
		let mysteryIndex = (numDaysFromStartDate < 27) ? (numDaysFromStartDate % 4) : ((numDaysFromStartDate+1) % 4)
		let mystery = mysteryTypes[mysteryIndex]
		let mysteryString = mystery.koreanTitle
		
		let mysteryAttributedString = NSAttributedString(string: mysteryString, attributes: [
			.font: Font.bf16,
			.foregroundColor: mystery.assignedColor
		])
		
		var additionalMysteryAttributedString: NSAttributedString?
		if numDaysFromStartDate == 26 || numDaysFromStartDate == 53 {
			additionalMysteryAttributedString = NSAttributedString(string: "영광의 신비", attributes: [
				.font: Font.bf16,
				.foregroundColor: Color.RosaryPurple
			])
		}
		
		// Assemble
		let progressDescription = NSMutableAttributedString()
		progressDescription.append(NSAttributedString(string: "오늘은 묵주기도 "))
		progressDescription.append(numDaysPassedAttributedString)
		progressDescription.append(NSAttributedString(string: "째이며, "))
		progressDescription.append(rosaryTypeAttributedString)
		progressDescription.append(NSAttributedString(string: ", "))
		progressDescription.append(mysteryAttributedString)
		if let additionalMysteryString = additionalMysteryAttributedString {
			progressDescription.append(NSAttributedString(string: ", "))
			progressDescription.append(additionalMysteryString)
		}
		progressDescription.append(NSAttributedString(string: "를 하실 차례입니다 🙂"))
		
		// Apply overall style
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = TextAttributes.LineSpacing.default
		progressDescription.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, progressDescription.length))
		
		return (progressDescription, numDaysFromStartDate)
	}
}

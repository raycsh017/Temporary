import UIKit
import SwiftyJSON

class HomeViewModel {
	private let noRosaryInProgressText: String = "현재 진행중인 묵주기도가 없습니다 😕"

	private let dateFormatter = DateFormatter()

	private let prayerTypes = PrayerType.all
	private let mysteryTypes = RosaryMystery.MysteryType.all

	private var recentRosaryRecord: RosaryRecord? {
		return RealmDataManager.shared.getFirstObject(ofType: RosaryRecord.self)
	}

	private var todayDateFormatted: String {
		dateFormatter.dateFormat = "MMMM dd"
		return dateFormatter.string(from: Date())
	}

}

extension HomeViewModel {
	func getCellConfigurators(completion: @escaping (([CellConfiguratorType]) -> Void)) {
		var cellConfigurators = [CellConfiguratorType]()

		cellConfigurators.append(prayerInfoCellConfigurator())
		cellConfigurators.append(contentsOf: prayerEntryCellConfigurators())

		completion(cellConfigurators)
	}

	private func prayerInfoCellConfigurator() -> CellConfiguratorType {
		let (progressDescription, numberOfDaysPassed) = currentRosaryInformation()
		let currentRosaryInfoCellData = HomeRosaryProgressCellData(currentDateText: todayDateFormatted, progressDescription: progressDescription, numberOfDaysPassed: numberOfDaysPassed)
		return TableCellConfigurator<HomeRosaryProgressTableViewCell>(cellData: currentRosaryInfoCellData)
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

	private func currentRosaryInformation() -> CurrentRosaryInfo {
		guard let recentRosaryRecord = recentRosaryRecord else {
			return (NSAttributedString(string: noRosaryInProgressText), 0)
		}

		dateFormatter.dateFormat = "MM/dd/yyyy"

		let startDate = recentRosaryRecord.startDate
		let startOfStartDate = Calendar.current.startOfDay(for: startDate)
		let startOfCurrentDate = Calendar.current.startOfDay(for: Date())
		let diffBetweenStartAndCurrentDates = Calendar.current.dateComponents([.day], from: startOfStartDate, to: startOfCurrentDate)

		guard let numDaysPassedSinceStart = diffBetweenStartAndCurrentDates.day,
			0 <= numDaysPassedSinceStart &&
			numDaysPassedSinceStart < RosaryConstants.numberOfDaysInPeriod else {
			return (NSAttributedString(string: noRosaryInProgressText), 0)
		}

		// x일
		let numDaysPassedString = "\(numDaysPassedSinceStart + 1)일"
		let numDaysPassedAttributedString = NSAttributedString(string: numDaysPassedString, attributes: [
			.font: Font.bf16
		])

		// xx기도
		var rosaryTypeString = ""
		switch numDaysPassedSinceStart {
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
		let mysteryIndex = (numDaysPassedSinceStart < 27) ? (numDaysPassedSinceStart % 4) : ((numDaysPassedSinceStart+1) % 4)
		let mystery = mysteryTypes[mysteryIndex]
		let mysteryString = mystery.koreanTitle

		let mysteryAttributedString = NSAttributedString(string: mysteryString, attributes: [
			.font: Font.bf16,
			.foregroundColor: mystery.assignedColor
		])

		var additionalMysteryAttributedString: NSAttributedString?
		if numDaysPassedSinceStart == 26 || numDaysPassedSinceStart == 53 {
			additionalMysteryAttributedString = NSAttributedString(string: "영광의 신비", attributes: [
				.font: Font.bf16,
				.foregroundColor: Color.Rosary.Purple
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

		return (progressDescription, numDaysPassedSinceStart)
	}
}

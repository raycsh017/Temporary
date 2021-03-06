import UIKit
import SwiftyJSON

class HomeViewModel {
	private let noRosaryProgressDescription = NSAttributedString(string: "진행중인 묵주기도가 없으신거 같네요 😕")
	private let noRosaryProgressBarColor = Color.Clear
	private let noRosaryProgress = 0

	private let finishedRosaryProgressDescription = NSAttributedString(string: "묵주기도를 끝내신 것 같네요! 🎉\n🙂 새로이 시작해보시는건 어떨까요?")
	private let finishedRosaryProgressBarColor = Color.CoralRed
	private let finishedRosaryProgress = RosaryConstants.numberOfDaysInPeriod

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

// MARK: - Assemble Cell Configurators
extension HomeViewModel {
	func getCellConfigurators(completion: @escaping (([CellConfiguratorType]) -> Void)) {
		var cellConfigurators = [CellConfiguratorType]()

		cellConfigurators.append(prayerInfoCellConfigurator())
		cellConfigurators.append(contentsOf: prayerEntryCellConfigurators())

		completion(cellConfigurators)
	}

	private func prayerInfoCellConfigurator() -> CellConfiguratorType {
		let (progressDescription, progressBarColor, rosaryProgress) = currentRosaryProgressInfo()
		let currentRosaryInfoCellData = HomeRosaryProgressCellData(currentDateText: todayDateFormatted, progressDescription: progressDescription, progressBarColor: progressBarColor, rosaryProgress: rosaryProgress)
		return TableCellConfigurator<HomeRosaryProgressTableViewCell>(cellData: currentRosaryInfoCellData)
	}

	private func prayerEntryCellConfigurators() -> [CellConfiguratorType] {
		let prayerEntryCellData = prayerTypes.map { HomePrayerEntryCellData(prayerType: $0) }
		let prayerEntryCellConfigurators = prayerEntryCellData.map { TableCellConfigurator<HomePrayerEntryTableViewCell>(cellData: $0) as CellConfiguratorType }
		return prayerEntryCellConfigurators
	}
}

// MARK: - Parsing & Formatting of Data
extension HomeViewModel {
	private func currentRosaryProgressInfo() -> (progressDescription: NSAttributedString, progressColor: UIColor, progress: Int) {
		guard let recentRosaryRecord = recentRosaryRecord else {
			return (noRosaryProgressDescription, noRosaryProgressBarColor, noRosaryProgress)
		}

		let startDate = recentRosaryRecord.startDate
		let startOfStartDate = Calendar.current.startOfDay(for: startDate)
		let startOfCurrentDate = Calendar.current.startOfDay(for: Date())
		let numberOfDaysPassed = Calendar.current.dateComponents([.day], from: startOfStartDate, to: startOfCurrentDate)

		let numDaysPassedSinceStart = numberOfDaysPassed.day ?? 0

		guard 0 <= numDaysPassedSinceStart && numDaysPassedSinceStart < RosaryConstants.numberOfDaysInPeriod else {
			if numDaysPassedSinceStart < 0 {
				return (noRosaryProgressDescription, noRosaryProgressBarColor, noRosaryProgress)
			} else {
				return (finishedRosaryProgressDescription, finishedRosaryProgressBarColor, finishedRosaryProgress)
			}
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
		let mysteryIndex = (numDaysPassedSinceStart < 27) ?
			(numDaysPassedSinceStart % 4) :
			((numDaysPassedSinceStart + 1) % 4)
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
		let mutableProgressDescription = NSMutableAttributedString()
		mutableProgressDescription.append(NSAttributedString(string: "오늘은 묵주기도 "))
		mutableProgressDescription.append(numDaysPassedAttributedString)
		mutableProgressDescription.append(NSAttributedString(string: "째이며, "))
		mutableProgressDescription.append(rosaryTypeAttributedString)
		mutableProgressDescription.append(NSAttributedString(string: ", "))
		mutableProgressDescription.append(mysteryAttributedString)
		if let additionalMysteryString = additionalMysteryAttributedString {
			mutableProgressDescription.append(NSAttributedString(string: ", "))
			mutableProgressDescription.append(additionalMysteryString)
		}
		mutableProgressDescription.append(NSAttributedString(string: "를 하실 차례입니다 🙏"))

		// Apply overall style
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = TextAttributes.LineSpacing.default
		mutableProgressDescription.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, mutableProgressDescription.length))

		let progressDescription = mutableProgressDescription
		let progressColor = mystery.assignedColor
		let progress = numDaysPassedSinceStart

		return (progressDescription, progressColor, progress)
	}
}

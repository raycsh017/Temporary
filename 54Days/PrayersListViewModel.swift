import UIKit
import SwiftyJSON

class PrayersListViewModel {
	// MARK: Static
	fileprivate let kTodaysPrayerInformationDefaultString: String = "현재 진행중인 묵주기도가 없습니다 :("
	
	fileprivate let calendar = Calendar.current
	fileprivate let dateFormatter = DateFormatter()
	fileprivate let todaysDate = Date()
	
	fileprivate let prayerTypes = PrayerType.all
	
	init() {
	}
	
	var cellConfigurators: [CellConfiguratorType] {
		var cellConfigurators = [CellConfiguratorType]()
		
		let miniCalendarDisplayData = MiniCalendarDisplayData(todaysDay: todaysDayFormatted(), todaysMonth: todaysMonthFormatted(), todaysPrayerInformation: todaysPrayerInformationAttributed())
		
		let prayersListDisplayData = PrayersListDisplayData(prayerTypes: prayerTypes)
		
		cellConfigurators.append(TableCellConfigurator<SpacingTableViewCell>(cellData: SpacingDisplayData(Spacing.s16)))
		cellConfigurators.append(TableCellConfigurator<MiniCalendarTableViewCell>(cellData: miniCalendarDisplayData))
		cellConfigurators.append(TableCellConfigurator<SpacingTableViewCell>(cellData: SpacingDisplayData(Spacing.s16)))
		cellConfigurators.append(TableCellConfigurator<PrayersListTableViewCell>(cellData: prayersListDisplayData))
		cellConfigurators.append(TableCellConfigurator<SpacingTableViewCell>(cellData: SpacingDisplayData(Spacing.s16)))
		
		return cellConfigurators
	}
}

// MiniCalendar
extension PrayersListViewModel {
	func todaysMonthFormatted() -> String {
		dateFormatter.dateFormat = "MMM"
		return dateFormatter.string(from: todaysDate)
	}
	
	func todaysDayFormatted() -> String {
		dateFormatter.dateFormat = "dd"
		return dateFormatter.string(from: todaysDate)
	}
	
	func todaysPrayerInformationAttributed() -> NSAttributedString {
		let rosaryPeriods = RealmManager.shared.rosaryPeriods
		
		guard let startDate = rosaryPeriods?.first?.startDate else {
			return NSAttributedString(string: kTodaysPrayerInformationDefaultString)
		}
		
		let startOfStartDate = calendar.startOfDay(for: startDate)
		let startOfCurrentDate = calendar.startOfDay(for: todaysDate)
		let diffBetweenTwoDates = calendar.dateComponents([.day], from: startOfStartDate, to: startOfCurrentDate)
		
		guard let numDaysFromStartDate = diffBetweenTwoDates.day, 0 <= numDaysFromStartDate && numDaysFromStartDate < 54 else {
			return NSAttributedString(string: kTodaysPrayerInformationDefaultString)
		}
		
		// _일
		let numDaysPassedString = "\(numDaysFromStartDate + 1)일"
		
		// _기도
		var rosaryTypeString = ""
		switch numDaysFromStartDate {
		case 0...26:
			rosaryTypeString = "청원기도"
		case 27...53:
			rosaryTypeString = "감사기도"
		default:
			break
		}
		
		// _의 신비
		let mysteryIndex = (numDaysFromStartDate < 27) ? (numDaysFromStartDate % 4) : ((numDaysFromStartDate+1) % 4)
		let mystery = RosaryMysteryType.all[mysteryIndex]
		let mysteryString = mystery.inKorean
		
		let numDaysPassedAttributedString = NSAttributedString(string: numDaysPassedString, attributes: [
			NSFontAttributeName: Font.f17
			])
		let rosaryTypeAttributedString = NSAttributedString(string: rosaryTypeString, attributes: [
			NSUnderlineStyleAttributeName: NSUnderlineStyle.styleThick
			])
		let mysteryAttributedString = NSAttributedString(string: mysteryString, attributes: [
			NSFontAttributeName: Font.f17,
			NSForegroundColorAttributeName: mystery.color
			])
		var additionalMysteryAttributedString: NSAttributedString?
		if numDaysFromStartDate == 26 || numDaysFromStartDate == 53 {
			additionalMysteryAttributedString = NSAttributedString(string: "영광의 신비", attributes: [
				NSFontAttributeName: Font.f17,
				NSForegroundColorAttributeName: Color.DarkSlateBlue
				])
		}
		
		let informationString = NSMutableAttributedString()
		informationString.append(NSAttributedString(string: "오늘은 묵주기도 "))
		informationString.append(numDaysPassedAttributedString)
		informationString.append(NSAttributedString(string: "째이며, "))
		informationString.append(rosaryTypeAttributedString)
		informationString.append(NSAttributedString(string: ", "))
		informationString.append(mysteryAttributedString)
		if let additionalMysteryString = additionalMysteryAttributedString {
			informationString.append(NSAttributedString(string: ", "))
			informationString.append(additionalMysteryString)
		}
		informationString.append(NSAttributedString(string: "를 하실 차례입니다 :)"))
		return informationString
	}
}

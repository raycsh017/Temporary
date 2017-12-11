import UIKit
import SwiftyJSON

class PrayerListViewModel {
	
	fileprivate let kcurrentPrayerInformationDefaultString: String = "현재 진행중인 묵주기도가 없습니다 :("
	
	fileprivate let calendar = Calendar.current
	fileprivate let dateFormatter = DateFormatter()
	fileprivate let currentDate = Date()
	
	fileprivate let prayerTypes = PrayerType.all
	
	init() {}
	
	func cellConfigurators() -> [CellConfiguratorType] {
		var cellConfigurators = [CellConfiguratorType]()
		
		let miniCalendarDisplayData = MiniCalendarTableCellData(currentDay: currentDayFormatted(), currentMonth: currentMonthFormatted(), currentPrayerInfo: currentPrayerInfoAttributed())
		
		cellConfigurators.append(TableCellConfigurator<MiniCalendarTableViewCell>(cellData: miniCalendarDisplayData))
		cellConfigurators.append(TableCellConfigurator<PrayerListTableViewCell>(cellData: PrayerListCellData()))
		
		return cellConfigurators
	}
}

// MiniCalendar
extension PrayerListViewModel {
	func currentMonthFormatted() -> String {
		dateFormatter.dateFormat = "MMM"
		return dateFormatter.string(from: currentDate)
	}
	
	func currentDayFormatted() -> String {
		dateFormatter.dateFormat = "dd"
		return dateFormatter.string(from: currentDate)
	}
	
	func currentPrayerInfoAttributed() -> NSAttributedString {
		let rosaryPeriods = RealmManager.shared.rosaryPeriods
		
		guard let startDate = rosaryPeriods?.first?.startDate else {
			return NSAttributedString(string: kcurrentPrayerInformationDefaultString)
		}
		
		let startOfStartDate = calendar.startOfDay(for: startDate)
		let startOfCurrentDate = calendar.startOfDay(for: currentDate)
		let diffBetweenTwoDates = calendar.dateComponents([.day], from: startOfStartDate, to: startOfCurrentDate)
		
		guard let numDaysFromStartDate = diffBetweenTwoDates.day, 0 <= numDaysFromStartDate && numDaysFromStartDate < 54 else {
			return NSAttributedString(string: kcurrentPrayerInformationDefaultString)
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
		let mystery = RosaryMystery.MysteryType.all[mysteryIndex]
		let mysteryString = mystery.koreanTitle
		
		let numDaysPassedAttributedString = NSAttributedString(string: numDaysPassedString, attributes: [
				NSFontAttributeName: Font.f17
			])
		let rosaryTypeAttributedString = NSAttributedString(string: rosaryTypeString, attributes: [
				NSUnderlineStyleAttributeName: NSUnderlineStyle.styleThick
			])
		let mysteryAttributedString = NSAttributedString(string: mysteryString, attributes: [
				NSFontAttributeName: Font.f17,
				NSForegroundColorAttributeName: mystery.assignedColor
			])
		var additionalMysteryAttributedString: NSAttributedString?
		if numDaysFromStartDate == 26 || numDaysFromStartDate == 53 {
			additionalMysteryAttributedString = NSAttributedString(string: "영광의 신비", attributes: [
					NSFontAttributeName: Font.f17,
					NSForegroundColorAttributeName: Color.DarkSlateBlue
				])
		}
		
		let prayerInfoString = NSMutableAttributedString()
		prayerInfoString.append(NSAttributedString(string: "오늘은 묵주기도 "))
		prayerInfoString.append(numDaysPassedAttributedString)
		prayerInfoString.append(NSAttributedString(string: "째이며, "))
		prayerInfoString.append(rosaryTypeAttributedString)
		prayerInfoString.append(NSAttributedString(string: ", "))
		prayerInfoString.append(mysteryAttributedString)
		if let additionalMysteryString = additionalMysteryAttributedString {
			prayerInfoString.append(NSAttributedString(string: ", "))
			prayerInfoString.append(additionalMysteryString)
		}
		prayerInfoString.append(NSAttributedString(string: "를 하실 차례입니다 :)"))
		return prayerInfoString
	}
}

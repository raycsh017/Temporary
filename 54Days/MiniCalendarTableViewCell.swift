import UIKit

struct MiniCalendarDisplayData {
	let todaysDay: String
	let todaysMonth: String
	let todaysPrayerInformation: NSAttributedString
}

class MiniCalendarTableViewCell: UITableViewCell {
	
	let miniCalendarView = MiniCalendarView()
	
	var miniCalendarDisplayData: MiniCalendarDisplayData?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		contentView.backgroundColor = Color.BackgroundGray
		
		contentView.addSubview(miniCalendarView)
		
		miniCalendarView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalToSuperview()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension MiniCalendarTableViewCell: CellUpdatable {
	typealias CellData = MiniCalendarDisplayData
	
	func update(withCellData cellData: MiniCalendarDisplayData) {
		miniCalendarDisplayData = cellData
		
		miniCalendarView.configure(calendarWith: cellData.todaysDay, monthString: cellData.todaysMonth, infoAttrString: cellData.todaysPrayerInformation)
	}
}

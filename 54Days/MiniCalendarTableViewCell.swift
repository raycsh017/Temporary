import UIKit

struct MiniCalendarTableCellData {
	let currentDay: String
	let currentMonth: String
	let currentPrayerInfo: NSAttributedString
}

class MiniCalendarTableViewCell: UITableViewCell {
	
	let kDateContainerWidth: CGFloat = 60.0
	let kCardViewHeight: CGFloat = 80.0
	let kDividerWidth: CGFloat = 2.0
	
	let roundCardView = RoundCardView(frame: .zero)
	let cardContentView = UIView()
	
	let dateContentView = UIView()
	
	let dayLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf20
		label.textColor = Color.Black
		label.textAlignment = .center
		return label
	}()
	
	let monthLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.Black
		label.textAlignment = .center
		return label
	}()
	
	let dateDividerView: UIView = {
		let view = UIView()
		view.backgroundColor = Color.BackgroundGray
		return view
	}()
	
	let prayerInfoLabel: UILabel = {
		let label = UILabel()
		label.font = Font.f14
		label.numberOfLines = 0
		return label
	}()
	
	var miniCalendarCellData: MiniCalendarTableCellData?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		contentView.backgroundColor = Color.BackgroundGray
		
		contentView.addSubview(roundCardView)
		
		roundCardView.addCardContentView(cardContentView)
		
		cardContentView.addSubview(dateContentView)
		cardContentView.addSubview(dateDividerView)
		cardContentView.addSubview(prayerInfoLabel)
		
		dateContentView.addSubview(dayLabel)
		dateContentView.addSubview(monthLabel)
		
		roundCardView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s8)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalToSuperview().offset(-Spacing.s8)
			make.height.equalTo(kCardViewHeight)
		}
		
		cardContentView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
		
		dateContentView.snp.makeConstraints { (make) in
			make.top.greaterThanOrEqualToSuperview()
			make.left.equalToSuperview()
			make.bottom.lessThanOrEqualToSuperview()
			make.centerY.equalToSuperview()
			make.width.equalTo(kDateContainerWidth)
		}
		
		dayLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		monthLabel.snp.makeConstraints { (make) in
			make.top.greaterThanOrEqualTo(dayLabel.snp.bottom).offset(Spacing.s4)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		dateDividerView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalTo(dateContentView.snp.right)
			make.bottom.equalToSuperview()
			make.width.equalTo(kDividerWidth)
		}
		
		prayerInfoLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s8)
			make.left.equalTo(dateDividerView.snp.right).offset(Spacing.s8)
			make.right.equalToSuperview().offset(-Spacing.s8)
			make.bottom.equalToSuperview().offset(-Spacing.s8)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension MiniCalendarTableViewCell: CellUpdatable {
	typealias CellData = MiniCalendarTableCellData
	
	func update(withCellData cellData: CellData) {
		miniCalendarCellData = cellData
		
		dayLabel.text = cellData.currentDay
		monthLabel.text = cellData.currentMonth
		prayerInfoLabel.attributedText = cellData.currentPrayerInfo
	}
}

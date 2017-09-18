import UIKit
import SnapKit

class MiniCalendarView: UIView {
	
	let kTodaysDateContainerSize: CGFloat = 75.0
	let kDividerWidth: CGFloat = 1.0
	
	let contentView = UIView()
	
	let todaysDateContainerView = UIView()
	let todaysDateContentView = UIView()
	
	let todaysDateDayLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf20
		label.textColor = Color.Black
		label.textAlignment = .center
		return label
	}()
	
	let todaysDateMonthLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.Black
		label.textAlignment = .center
		return label
	}()
	
	let todaysDateDividerView: UIView = {
		let view = UIView()
		view.backgroundColor = Color.BackgroundGray
		return view
	}()
	
	let todaysPrayerContainerView = UIView()
	
	let todaysPrayerInformationLabel: UILabel = {
		let label = UILabel()
		label.font = Font.f14
		label.numberOfLines = 0
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		layer.cornerRadius = CornerRadius.cr4
		backgroundColor = Color.White
		applyShadow()
		
		addSubview(contentView)
		
		contentView.addSubview(todaysDateContainerView)
		contentView.addSubview(todaysDateDividerView)
		contentView.addSubview(todaysPrayerContainerView)
		
		todaysDateContainerView.addSubview(todaysDateContentView)
		
		todaysDateContentView.addSubview(todaysDateDayLabel)
		todaysDateContentView.addSubview(todaysDateMonthLabel)
		
		todaysPrayerContainerView.addSubview(todaysPrayerInformationLabel)
		
		contentView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
		
		todaysDateContainerView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.bottom.equalToSuperview()
			make.width.equalTo(todaysDateContainerView.snp.height)
		}
		
		todaysDateContentView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview().inset(UIEdgeInsets.make(with: Spacing.s16))
		}
		
		todaysDateDayLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		todaysDateMonthLabel.snp.makeConstraints { (make) in
			make.top.equalTo(todaysDateDayLabel.snp.bottom).offset(Spacing.s4)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		todaysDateDividerView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalTo(todaysDateContainerView.snp.right)
			make.bottom.equalToSuperview()
			make.width.equalTo(kDividerWidth)
		}
		
		todaysPrayerContainerView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalTo(todaysDateDividerView.snp.right)
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		todaysPrayerInformationLabel.snp.makeConstraints { (make) in
			make.top.greaterThanOrEqualToSuperview()
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.lessThanOrEqualToSuperview()
			make.centerY.equalToSuperview()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(calendarWith dayString: String, monthString: String, infoAttrString: NSAttributedString) {
		todaysDateDayLabel.text = dayString
		todaysDateMonthLabel.text = monthString
		todaysPrayerInformationLabel.attributedText = infoAttrString
	}
}

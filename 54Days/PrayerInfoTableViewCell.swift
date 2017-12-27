import UIKit
import SnapKit

class PrayerInfoCellData {
	let dateText: String
	let infoAttributedText: NSAttributedString
	let numberOfDaysPassed: Int
	
	init(dateText: String, infoAttributedText: NSAttributedString, numberOfDaysPassed: Int) {
		self.dateText = dateText
		self.infoAttributedText = infoAttributedText
		self.numberOfDaysPassed = numberOfDaysPassed
	}
}

class PrayerInfoTableViewCell: UITableViewCell {
	
	let dateLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf16
		label.textColor = Color.BalticSeaGray
		label.textAlignment = .left
		return label
	}()
	
	let infoLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf12
		label.textColor = Color.BalticSeaGray
		label.textAlignment = .left
		return label
	}()
	
	let underlineView: UIView = {
		let view = UIView()
		view.backgroundColor = Color.BackgroundGray
		return view
	}()
	
	var prayerInfoCellData: PrayerInfoCellData?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		backgroundColor = Color.White
		contentView.backgroundColor = Color.White
		
		contentView.addSubview(dateLabel)
		contentView.addSubview(infoLabel)
		contentView.addSubview(underlineView)
		
		dateLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s12)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
		}
		
		infoLabel.snp.makeConstraints { (make) in
			make.top.equalTo(dateLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalTo(underlineView.snp.top).offset(-Spacing.s12)
		}
		
		let underlineThickness: CGFloat = 1.0
		
		underlineView.snp.makeConstraints { (make) in
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
			make.height.equalTo(underlineThickness)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension PrayerInfoTableViewCell: CellUpdatable {
	typealias CellData = PrayerInfoCellData
	
	func update(withCellData cellData: CellData) {
		prayerInfoCellData = cellData
		
		dateLabel.text = cellData.dateText
		infoLabel.attributedText = cellData.infoAttributedText
	}
}

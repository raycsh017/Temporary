import UIKit
import SnapKit

class OtherPrayerTableCellData {
	let title: String
	let body: NSAttributedString
	
	init(title: String, body: NSAttributedString) {
		self.title = title
		self.body = body
	}
}

class OtherPrayerTableViewCell: UITableViewCell {
	
	let contentInsetView = UIView()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf24
		label.textColor = Color.Black
		label.textAlignment = .left
		return label
	}()
	
	let bodyLabel: UILabel = {
		let label = UILabel()
		label.font = Font.f16
		label.textColor = Color.Black
		label.textAlignment = .left
		label.numberOfLines = 0
		return label
	}()
	
	var otherPrayerCellData: OtherPrayerTableCellData?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		backgroundColor = Color.White
		contentView.backgroundColor = Color.White
		
		contentView.addSubview(contentInsetView)
		
		contentInsetView.addSubview(titleLabel)
		contentInsetView.addSubview(bodyLabel)
		
		contentInsetView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s24)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalToSuperview().offset(-Spacing.s24)
		}
		
		titleLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		bodyLabel.snp.makeConstraints { (make) in
			make.top.equalTo(titleLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		contentView.applyUnderline()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension OtherPrayerTableViewCell: CellUpdatable {
	typealias CellData = OtherPrayerTableCellData
	
	func update(withCellData cellData: CellData) {
		otherPrayerCellData = cellData
		
		titleLabel.text = cellData.title
		bodyLabel.attributedText = cellData.body
	}
}


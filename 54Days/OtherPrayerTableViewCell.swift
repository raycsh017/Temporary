import UIKit
import SnapKit

class OtherPrayerTableViewCell: UITableViewCell {
	
	let roundCardView = RoundCardView(frame: .zero)
	
	let cardContentView = UIView()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.Black
		label.textAlignment = .left
		return label
	}()
	
	let bodyLabel: UILabel = {
		let label = UILabel()
		label.font = Font.f14
		label.textColor = Color.Black
		label.textAlignment = .left
		label.numberOfLines = 0
		return label
	}()
	
	var otherPrayerCellData: OtherPrayerTableCellData?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		contentView.backgroundColor = Color.BackgroundGray
		
		contentView.addSubview(roundCardView)
		
		roundCardView.addCardContentView(cardContentView)
		
		cardContentView.addSubview(titleLabel)
		cardContentView.addSubview(bodyLabel)
		
		roundCardView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s8)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalToSuperview().offset(-Spacing.s8)
		}
		
		cardContentView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
		
		titleLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s16)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
		}
		
		bodyLabel.snp.makeConstraints { (make) in
			make.top.equalTo(titleLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalToSuperview().offset(-Spacing.s16)
		}
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


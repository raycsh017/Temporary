import UIKit
import SnapKit

class PrayerEntryCellData {
	let prayerType: PrayerType
	
	init(prayerType: PrayerType) {
		self.prayerType = prayerType
	}
}

protocol PrayerEntryTableViewCellDelegate: class {
	func prayerEntryTableViewCell(_ cell: PrayerEntryTableViewCell, didSelectPrayer prayerType: PrayerType)
}

class PrayerEntryTableViewCell: UITableViewCell {
	
	let iconView: UIView = {
		let view = UIView()
		return view
	}()
	
	let iconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.tintColor = Color.White
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	let iconBackgroundView: UIView = {
		let view = UIView()
		view.backgroundColor = Color.SilverSandGray
		view.layer.cornerRadius = CornerRadius.cr4
		return view
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf16
		label.textColor = Color.BalticSeaGray
		return label
	}()
	
	let underlineView: UIView = {
		let view = UIView()
		view.backgroundColor = Color.BackgroundGray
		return view
	}()
	
	weak var delegate: PrayerEntryTableViewCellDelegate?
	var prayerEntryCellData: PrayerEntryCellData?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		accessoryType = .disclosureIndicator
		backgroundColor = Color.White
		contentView.backgroundColor = Color.White
		
		contentView.addSubview(iconView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(underlineView)
		
		iconView.addSubview(iconBackgroundView)
		iconView.addSubview(iconImageView)
		
		iconView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s12)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.bottom.equalTo(underlineView.snp.top).offset(-Spacing.s12)
			make.size.equalTo(40.0)
		}
		
		iconBackgroundView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
		
		iconImageView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview().inset(UIEdgeInsets.make(with: 6))
		}
		
		titleLabel.snp.makeConstraints { (make) in
			make.left.equalTo(iconView.snp.right).offset(Spacing.s12)
			make.centerY.equalToSuperview()
		}
		
		let underlineThickness: CGFloat = 1.0
		
		underlineView.snp.makeConstraints { (make) in
			make.left.equalTo(titleLabel.snp.left)
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
			make.height.equalTo(underlineThickness)
		}
		
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedCell(_:)))
		addGestureRecognizer(tapGestureRecognizer)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc func tappedCell(_ sender: AnyObject) {
		guard let prayerType = prayerEntryCellData?.prayerType else {
			return
		}
		delegate?.prayerEntryTableViewCell(self, didSelectPrayer: prayerType)
	}
}

extension PrayerEntryTableViewCell: CellUpdatable {
	typealias CellData = PrayerEntryCellData
	
	func update(withCellData cellData: CellData) {
		prayerEntryCellData = cellData
		
		let prayerType = cellData.prayerType
		titleLabel.text = prayerType.koreanTitle
		iconImageView.image = prayerType.assignedIcon?
							  .withRenderingMode(.alwaysTemplate)
		iconBackgroundView.backgroundColor = prayerType.assignedColor
	}
}

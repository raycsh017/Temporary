import UIKit
import SnapKit

protocol PrayersListItemViewDelegate: class {
	func prayersListItemView(_ prayersListItemView: PrayersListItemView, didSelectPrayer prayerType: PrayerType)
}

class PrayersListItemView: UIView {

	let kIconSize: CGFloat = 32.0
	
	let contentView = UIView()
	
	let iconImageView: UIImageView = {
		let imageview = UIImageView()
		imageview.contentMode = .scaleAspectFit
		return imageview
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf17
		label.textColor = Color.Black
		return label
	}()
	
	weak var delegate: PrayersListItemViewDelegate?
	
	var prayerType: PrayerType?

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		layer.cornerRadius = CornerRadius.cr4
		backgroundColor = Color.White
		applyShadow()
		
		addSubview(contentView)
		
		contentView.addSubview(iconImageView)
		contentView.addSubview(titleLabel)
		
		contentView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview().inset(UIEdgeInsets.make(with: Spacing.s16))
		}
		
		iconImageView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.bottom.equalToSuperview()
			make.width.equalTo(kIconSize)
			make.height.equalTo(iconImageView.snp.width)
		}
		
		titleLabel.snp.makeConstraints { (make) in
			make.left.equalTo(iconImageView.snp.right).offset(Spacing.s8)
			make.right.equalToSuperview()
			make.centerY.equalToSuperview()
		}
		
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
		addGestureRecognizer(tapGestureRecognizer)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with type: PrayerType) {
		prayerType = type
		
		iconImageView.image = type.icon
		titleLabel.text = type.title
	}
	
	@objc private func viewTapped(_ sender: AnyObject) {
		guard let prayerType = prayerType else { return }
		
		delegate?.prayersListItemView(self, didSelectPrayer: prayerType)
	}
}

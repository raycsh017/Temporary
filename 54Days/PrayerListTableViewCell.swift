import UIKit

struct PrayerListCellData {
	let prayerTypes: [PrayerType] = PrayerType.all
}

protocol PrayerListTableViewCellDelegate: class {
	func prayerListTableViewCell(_ cell: PrayerListTableViewCell, didSelectPrayer prayerType: PrayerType)
}

class PrayerListTableViewCell: UITableViewCell {
	
	let listHeaderLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.HeaderGray
		label.text = "오늘하실 기도를 선택해주세요"
		return label
	}()
	
	let listContentScrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.contentInset = UIEdgeInsets.make(withVerticalInset: 0, horizontalInset: Spacing.s16)
		scrollView.showsHorizontalScrollIndicator = false
		return scrollView
	}()
	
	let listContentStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .equalSpacing
		stackView.spacing = CGFloat(Spacing.s16)
		return stackView
	}()
	
	weak var delegate: PrayerListTableViewCellDelegate?
	var prayerListCellData: PrayerListCellData?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		backgroundColor = UIColor.clear
		contentView.backgroundColor = UIColor.clear
		
		contentView.addSubview(listHeaderLabel)
		contentView.addSubview(listContentScrollView)
		
		listContentScrollView.addSubview(listContentStackView)
		
		listHeaderLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s8)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
		}
		
		listContentScrollView.snp.makeConstraints { (make) in
			make.top.equalTo(listHeaderLabel.snp.bottom)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		listContentStackView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
			make.height.equalTo(listContentScrollView)
		}
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension PrayerListTableViewCell: CellUpdatable {
	typealias CellData = PrayerListCellData
	
	func update(withCellData cellData: CellData) {
		prayerListCellData = cellData
		
		listContentStackView.removeAllArrangedSubviews()
		
		for prayerType in cellData.prayerTypes {
			let prayerListItemView = PrayerListItemView(frame: .zero, prayerType: prayerType)
			prayerListItemView.delegate = self
			listContentStackView.addArrangedSubview(prayerListItemView)
		}
	}
}

extension PrayerListTableViewCell: PrayerListItemViewDelegate {
	func prayerListItemView(_ prayerListItemView: PrayerListItemView, didSelectPrayer prayerType: PrayerType) {
		delegate?.prayerListTableViewCell(self, didSelectPrayer: prayerType)
	}
}

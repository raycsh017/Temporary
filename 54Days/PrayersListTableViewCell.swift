import UIKit

struct PrayersListDisplayData {
	let prayerTypes: [PrayerType]
}

protocol PrayersListTableViewCellDelegate: class {
	func prayersListTableViewCell(_ cell: PrayersListTableViewCell, didSelectPrayer prayerType: PrayerType)
}

class PrayersListTableViewCell: UITableViewCell {
	
	let stackContainerView: UIView = {
		let view = UIView()
		return view
	}()
	
	let firstColumnStackView: UIStackView = {
		let stackview = UIStackView()
		stackview.axis = .vertical
		stackview.alignment = .fill
		stackview.distribution = .fillEqually
		stackview.spacing = CGFloat(Spacing.s16)
		return stackview
	}()
	
	lazy var joyfulPrayerListItemView: PrayersListItemView = {
		let view = PrayersListItemView()
		view.delegate = self
		return view
	}()
	
	lazy var lightPrayerListItemView: PrayersListItemView = {
		let view = PrayersListItemView()
		view.delegate = self
		return view
	}()
	
	lazy var otherPrayerListItemView: PrayersListItemView = {
		let view: PrayersListItemView = PrayersListItemView()
		view.delegate = self
		return view
	}()
	
	let secondColumnStackView: UIStackView = {
		let stackview = UIStackView()
		stackview.axis = .vertical
		stackview.alignment = .fill
		stackview.distribution = .fillEqually
		stackview.spacing = CGFloat(Spacing.s16)
		return stackview
	}()
	
	lazy var sorrowfulPrayerListItemView: PrayersListItemView = {
		let view = PrayersListItemView()
		view.delegate = self
		return view
	}()
	
	lazy var gloriousPrayerListItemView: PrayersListItemView = {
		let view = PrayersListItemView()
		view.delegate = self
		return view
	}()
	
	weak var delegate: PrayersListTableViewCellDelegate?
	
	var prayersListDisplayData: PrayersListDisplayData?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		backgroundColor = UIColor.clear
		contentView.backgroundColor = UIColor.clear
		
		contentView.addSubview(stackContainerView)
		
		stackContainerView.addSubview(firstColumnStackView)
		stackContainerView.addSubview(secondColumnStackView)
		
		firstColumnStackView.addArrangedSubview(joyfulPrayerListItemView)
		firstColumnStackView.addArrangedSubview(sorrowfulPrayerListItemView)
		firstColumnStackView.addArrangedSubview(otherPrayerListItemView)
		
		secondColumnStackView.addArrangedSubview(lightPrayerListItemView)
		secondColumnStackView.addArrangedSubview(gloriousPrayerListItemView)
		
		stackContainerView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalToSuperview()
		}
		
		firstColumnStackView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.bottom.equalToSuperview()
			make.right.equalTo(secondColumnStackView.snp.left).offset(-Spacing.s16)
			make.width.equalTo(secondColumnStackView.snp.width)
		}
		
		secondColumnStackView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.lessThanOrEqualToSuperview()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension PrayersListTableViewCell: CellUpdatable {
	typealias CellData = PrayersListDisplayData
	
	func update(withCellData cellData: PrayersListDisplayData) {
		self.prayersListDisplayData = cellData
		
		prayersListDisplayData?.prayerTypes.forEach { type in
			switch type {
			case .rosary(let mystery):
				switch mystery {
				case .joyful:
					joyfulPrayerListItemView.configure(with: type)
				case .light:
					lightPrayerListItemView.configure(with: type)
				case .sorrowful:
					sorrowfulPrayerListItemView.configure(with: type)
				case .glorious:
					gloriousPrayerListItemView.configure(with: type)
				}
			case .other:
				otherPrayerListItemView.configure(with: type)
			}
		}
	}
}

extension PrayersListTableViewCell: PrayersListItemViewDelegate {
	func prayersListItemView(_ prayersListItemView: PrayersListItemView, didSelectPrayer prayerType: PrayerType) {
		delegate?.prayersListTableViewCell(self, didSelectPrayer: prayerType)
	}
}

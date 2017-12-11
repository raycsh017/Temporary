import UIKit
import SnapKit

class RosaryStartingPrayerTableViewCell: UITableViewCell {
	
	let roundCardView = RoundCardView(frame: .zero)
	
	let cardContentStackView: UIStackView = {
		let stackview = UIStackView()
		stackview.axis = .vertical
		stackview.alignment = .fill
		stackview.distribution = .equalSpacing
		stackview.spacing = CGFloat(Spacing.s8)
		return stackview
	}()
	
	let signOfTheCrossLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.Black
		label.textAlignment = .center
		label.text = "성부와 성자와 성령의 이름으로, 아멘."
		label.numberOfLines = 0
		return label
	}()
	
	let hailMaryTitleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.Black
		label.textAlignment = .center
		label.text = "성모송"
		label.numberOfLines = 0
		return label
	}()
	
	let petitionPrayerTitleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.Ocean
		label.textAlignment = .center
		label.text = "청원기도"
		label.numberOfLines = 0
		return label
	}()
	
	let petitionPrayerBodyLabel: UILabel = {
		let label = UILabel()
		label.font = Font.f14
		label.textColor = Color.Black
		label.textAlignment = .left
		label.numberOfLines = 0
		return label
	}()
	
	let gracePrayerTitleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.Ocean
		label.textAlignment = .center
		label.text = "감사기도"
		label.numberOfLines = 0
		return label
	}()
	
	let gracePrayerBodyLabel: UILabel = {
		let label = UILabel()
		label.font = Font.f14
		label.textColor = Color.Black
		label.textAlignment = .left
		label.numberOfLines = 0
		return label
	}()
	
	let listOfPrayersLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.Ocean
		label.textAlignment = .left
		label.text = "사도신경, 주님의 기도, 성모송(세 번), 영광송, 구원의 기도"
		label.numberOfLines = 0
		return label
	}()
	
	var rosaryStartingPrayerCellData: RosaryStartingPrayerTableCellData?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		contentView.backgroundColor = Color.BackgroundGray
		
		contentView.addSubview(roundCardView)
		
		roundCardView.addCardContentView(cardContentStackView)
		
		roundCardView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s8)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalToSuperview().offset(-Spacing.s8)
		}
		
		cardContentStackView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview().inset(UIEdgeInsets.make(with: Spacing.s16))
		}
		
		cardContentStackView.addArrangedSubview(signOfTheCrossLabel)
		cardContentStackView.addArrangedSubview(hailMaryTitleLabel)
		cardContentStackView.addArrangedSubview(petitionPrayerTitleLabel)
		cardContentStackView.addArrangedSubview(petitionPrayerBodyLabel)
		cardContentStackView.addArrangedSubview(gracePrayerTitleLabel)
		cardContentStackView.addArrangedSubview(gracePrayerBodyLabel)
		cardContentStackView.addArrangedSubview(listOfPrayersLabel)
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension RosaryStartingPrayerTableViewCell: CellUpdatable {
	typealias CellData = RosaryStartingPrayerTableCellData
	
	func update(withCellData cellData: CellData) {
		rosaryStartingPrayerCellData = cellData
		
		petitionPrayerBodyLabel.text = cellData.petitionPrayer
		gracePrayerBodyLabel.text = cellData.gracePrayer
	}
}


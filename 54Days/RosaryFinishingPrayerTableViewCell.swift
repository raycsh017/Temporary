import UIKit
import SnapKit

class RosaryFinishingPrayerTableViewCell: UITableViewCell {
	
	let roundCardView = RoundCardView(frame: .zero)
	
	let cardContentStackView: UIStackView = {
		let stackview = UIStackView()
		stackview.axis = .vertical
		stackview.alignment = .fill
		stackview.distribution = .equalSpacing
		stackview.spacing = CGFloat(Spacing.s8)
		return stackview
	}()
	
	let spiritPrayerTitleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.Ocean
		label.textAlignment = .center
		label.text = "신령성체의 기도"
		label.numberOfLines = 0
		return label
	}()
	
	let spiritPrayerBodyLabel: UILabel = {
		let label = UILabel()
		label.font = Font.f14
		label.textColor = Color.Black
		label.textAlignment = .center
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
	
	let hailMaryTitleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.Black
		label.textAlignment = .center
		label.text = "성모송"
		label.numberOfLines = 0
		return label
	}()
	
	let hailHolyQueenTitleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.Ocean
		label.textAlignment = .center
		label.text = "성모찬송"
		label.numberOfLines = 0
		return label
	}()
	
	let praiseFirstPartLabel: UILabel = {
		let label = UILabel()
		label.font = Font.f14
		label.textColor = Color.Black
		label.textAlignment = .left
		label.numberOfLines = 0
		return label
	}()
	
	let praiseSecondPartLabel: UILabel = {
		let label = UILabel()
		label.font = Font.f14
		label.textColor = Color.Black
		label.textAlignment = .left
		label.numberOfLines = 0
		return label
	}()
	
	let signOfTheCrossLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.Black
		label.textAlignment = .left
		label.text = "성부와 성자와 성령의 이름으로, 아멘."
		label.numberOfLines = 0
		return label
	}()
	
	var rosaryFinishingPrayerCellData: RosaryFinishingPrayerTableCellData?
	
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
		
		cardContentStackView.addArrangedSubview(spiritPrayerTitleLabel)
		cardContentStackView.addArrangedSubview(spiritPrayerBodyLabel)
		cardContentStackView.addArrangedSubview(petitionPrayerTitleLabel)
		cardContentStackView.addArrangedSubview(petitionPrayerBodyLabel)
		cardContentStackView.addArrangedSubview(gracePrayerTitleLabel)
		cardContentStackView.addArrangedSubview(gracePrayerBodyLabel)
		cardContentStackView.addArrangedSubview(hailMaryTitleLabel)
		cardContentStackView.addArrangedSubview(praiseFirstPartLabel)
		cardContentStackView.addArrangedSubview(praiseSecondPartLabel)
		cardContentStackView.addArrangedSubview(signOfTheCrossLabel)
		
		cardContentStackView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview().inset(UIEdgeInsets.make(with: Spacing.s16))
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension RosaryFinishingPrayerTableViewCell: CellUpdatable {
	typealias CellData = RosaryFinishingPrayerTableCellData
	
	func update(withCellData cellData: CellData) {
		rosaryFinishingPrayerCellData = cellData
		
		spiritPrayerBodyLabel.text = cellData.spiritPrayer
		petitionPrayerBodyLabel.text = cellData.petitionPrayer
		gracePrayerBodyLabel.text = cellData.gracePrayer
		praiseFirstPartLabel.text = cellData.praiseFirstPart
		praiseSecondPartLabel.text = cellData.praiseSecondPart
	}
}



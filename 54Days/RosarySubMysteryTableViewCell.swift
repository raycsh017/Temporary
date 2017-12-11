import UIKit
import SnapKit

class RosarySubMysteryTableViewCell: UITableViewCell {
	
	let roundCardView = RoundCardView(frame: .zero)
	
	let cardContentStackView: UIStackView = {
		let stackview = UIStackView()
		stackview.axis = .vertical
		stackview.alignment = .fill
		stackview.distribution = .equalSpacing
		stackview.spacing = CGFloat(Spacing.s16)
		return stackview
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.Ocean
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	
	let subTextLabel: UILabel = {
		let label = UILabel()
		label.font = Font.f14
		label.textColor = Color.CrimsonGlory
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	
	let mainTextLabel: UILabel = {
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
		label.textAlignment = .center
		label.text = "주님의 기도, 성모송(열 번), 영광송, 구원의 기도"
		label.numberOfLines = 0
		return label
	}()
	
	let endingTextLabel: UILabel = {
		let label = UILabel()
		label.font = Font.f14
		label.textColor = Color.Black
		label.textAlignment = .left
		label.numberOfLines = 0
		return label
	}()
	
	var rosarySubMysteryTableCellData: RosarySubMysteryTableCellData?
	
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
		
		cardContentStackView.addArrangedSubview(titleLabel)
		cardContentStackView.addArrangedSubview(subTextLabel)
		cardContentStackView.addArrangedSubview(mainTextLabel)
		cardContentStackView.addArrangedSubview(listOfPrayersLabel)
		cardContentStackView.addArrangedSubview(endingTextLabel)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension RosarySubMysteryTableViewCell: CellUpdatable {
	typealias CellData = RosarySubMysteryTableCellData
	
	func update(withCellData cellData: CellData) {
		rosarySubMysteryTableCellData = cellData
		
		titleLabel.text = cellData.title
		subTextLabel.text = cellData.subText
		mainTextLabel.text = cellData.mainText
		endingTextLabel.text = cellData.endingText
	}
}



import UIKit
import SnapKit

class PrayerRosaryStartingPrayerTableCellData {
	let petitionPrayer: String
	let gracePrayer: String
	
	init(petitionPrayer: String, gracePrayer: String) {
		self.petitionPrayer = petitionPrayer
		self.gracePrayer = gracePrayer
	}
}

class PrayerRosaryStartingPrayerTableViewCell: UITableViewCell {
	
	let contentInsetView = UIView()
	
	let titleLabel: Label = {
		let label = Label()
		label.font = Font.bf24
		label.textColor = Color.Black
		label.textAlignment = .left
		label.text = "시작기도"
		return label
	}()
	
	let signOfTheCrossLabel: Label = {
		let label = Label()
		label.font = Font.f16
		label.textColor = Color.Black
		label.textAlignment = .left
		label.text = "성부와 성자와 성령의 이름으로, 아멘."
		label.numberOfLines = 0
		return label
	}()
	
	let hailMaryTitleLabel: Label = {
		let label = Label()
		label.font = Font.bf16
		label.textColor = Color.Black
		label.textAlignment = .left
		label.text = "성모송"
		return label
	}()
	
	let petitionPrayerTitleLabel: Label = {
		let label = Label()
		label.font = Font.bf16
		label.textColor = Color.OceanBlue
		label.textAlignment = .left
		label.text = "청원기도"
		return label
	}()
	
	let petitionPrayerBodyLabel: Label = {
		let label = Label()
		label.font = Font.f16
		label.textColor = Color.Black
		label.textAlignment = .left
		label.numberOfLines = 0
		label.textAttributes = TextAttributes.Predefined.Paragraph
		return label
	}()
	
	let gracePrayerTitleLabel: Label = {
		let label = Label()
		label.font = Font.bf16
		label.textColor = Color.OceanBlue
		label.textAlignment = .left
		label.text = "감사기도"
		return label
	}()
	
	let gracePrayerBodyLabel: Label = {
		let label = Label()
		label.font = Font.f16
		label.textColor = Color.Black
		label.textAlignment = .left
		label.numberOfLines = 0
		label.textAttributes = TextAttributes.Predefined.Paragraph
		return label
	}()
	
	let listOfPrayersLabel: Label = {
		let label = Label()
		label.font = Font.bf16
		label.textColor = Color.OceanBlue
		label.textAlignment = .left
		label.text = "사도신경, 주님의 기도, 성모송(세 번), 영광송, 구원의 기도"
		label.numberOfLines = 0
		return label
	}()
	
	var rosaryStartingPrayerCellData: PrayerRosaryStartingPrayerTableCellData?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		backgroundColor = Color.White
		contentView.backgroundColor = Color.White
		
		contentView.addSubview(contentInsetView)
		
		contentInsetView.addSubview(titleLabel)
		contentInsetView.addSubview(signOfTheCrossLabel)
		contentInsetView.addSubview(hailMaryTitleLabel)
		contentInsetView.addSubview(petitionPrayerTitleLabel)
		contentInsetView.addSubview(petitionPrayerBodyLabel)
		contentInsetView.addSubview(gracePrayerTitleLabel)
		contentInsetView.addSubview(gracePrayerBodyLabel)
		contentInsetView.addSubview(listOfPrayersLabel)
		
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
		
		signOfTheCrossLabel.snp.makeConstraints { (make) in
			make.top.equalTo(titleLabel.snp.bottom).offset(Spacing.s16)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		hailMaryTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(signOfTheCrossLabel.snp.bottom).offset(Spacing.s16)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		petitionPrayerTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(hailMaryTitleLabel.snp.bottom).offset(Spacing.s16)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		petitionPrayerBodyLabel.snp.makeConstraints { (make) in
			make.top.equalTo(petitionPrayerTitleLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		gracePrayerTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(petitionPrayerBodyLabel.snp.bottom).offset(Spacing.s16)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		gracePrayerBodyLabel.snp.makeConstraints { (make) in
			make.top.equalTo(gracePrayerTitleLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		listOfPrayersLabel.snp.makeConstraints { (make) in
			make.top.equalTo(gracePrayerBodyLabel.snp.bottom).offset(Spacing.s16)
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

extension PrayerRosaryStartingPrayerTableViewCell: CellUpdatable {
	typealias CellData = PrayerRosaryStartingPrayerTableCellData
	
	func update(withCellData cellData: CellData) {
		rosaryStartingPrayerCellData = cellData
		
		petitionPrayerBodyLabel.text = cellData.petitionPrayer
		gracePrayerBodyLabel.text = cellData.gracePrayer
	}
}


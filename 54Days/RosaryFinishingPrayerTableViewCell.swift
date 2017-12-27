import UIKit
import SnapKit

class RosaryFinishingPrayerTableCellData {
	let spiritPrayer: String
	let petitionPrayer: String
	let gracePrayer: String
	let praiseFirstPart: String
	let praiseSecondPart: String
	
	init(spiritPrayer: String, petitionPrayer: String, gracePrayer: String, praiseFirstPart: String, praiseSecondPart: String) {
		self.spiritPrayer = spiritPrayer
		self.petitionPrayer = petitionPrayer
		self.gracePrayer = gracePrayer
		self.praiseFirstPart = praiseFirstPart
		self.praiseSecondPart = praiseSecondPart
	}
}

class RosaryFinishingPrayerTableViewCell: UITableViewCell {
	
	let contentInsetView = UIView()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf20
		label.textColor = Color.Black
		label.textAlignment = .left
		label.text = "마침기도"
		return label
	}()
	
	let spiritPrayerTitleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.OceanBlue
		label.textAlignment = .left
		label.text = "신령성체의 기도"
		return label
	}()
	
	let spiritPrayerBodyLabel: UILabel = {
		let label = UILabel()
		label.font = Font.f14
		label.textColor = Color.Black
		label.textAlignment = .left
		label.numberOfLines = 0
		return label
	}()
	
	let petitionPrayerTitleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.OceanBlue
		label.textAlignment = .left
		label.text = "청원기도"
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
		label.textColor = Color.OceanBlue
		label.textAlignment = .left
		label.text = "감사기도"
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
		label.textAlignment = .left
		label.text = "성모송"
		return label
	}()
	
	let hailHolyQueenTitleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.OceanBlue
		label.textAlignment = .left
		label.text = "성모찬송"
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
		
		backgroundColor = Color.White
		contentView.backgroundColor = Color.White
		
		contentView.addSubview(contentInsetView)
		
		contentInsetView.addSubview(titleLabel)
		contentInsetView.addSubview(spiritPrayerTitleLabel)
		contentInsetView.addSubview(spiritPrayerBodyLabel)
		contentInsetView.addSubview(petitionPrayerTitleLabel)
		contentInsetView.addSubview(petitionPrayerBodyLabel)
		contentInsetView.addSubview(gracePrayerTitleLabel)
		contentInsetView.addSubview(gracePrayerBodyLabel)
		contentInsetView.addSubview(hailMaryTitleLabel)
		contentInsetView.addSubview(hailHolyQueenTitleLabel)
		contentInsetView.addSubview(praiseFirstPartLabel)
		contentInsetView.addSubview(praiseSecondPartLabel)
		contentInsetView.addSubview(signOfTheCrossLabel)
		
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
		
		spiritPrayerTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(titleLabel.snp.bottom).offset(Spacing.s16)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		spiritPrayerBodyLabel.snp.makeConstraints { (make) in
			make.top.equalTo(spiritPrayerTitleLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		petitionPrayerTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(spiritPrayerBodyLabel.snp.bottom).offset(Spacing.s16)
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
		
		hailMaryTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(gracePrayerBodyLabel.snp.bottom).offset(Spacing.s16)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		hailHolyQueenTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(hailMaryTitleLabel.snp.bottom).offset(Spacing.s16)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		praiseFirstPartLabel.snp.makeConstraints { (make) in
			make.top.equalTo(hailHolyQueenTitleLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		praiseSecondPartLabel.snp.makeConstraints { (make) in
			make.top.equalTo(praiseFirstPartLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		signOfTheCrossLabel.snp.makeConstraints { (make) in
			make.top.equalTo(praiseSecondPartLabel.snp.bottom).offset(Spacing.s16)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
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



import UIKit
import SnapKit

class RosarySubMysteryTableCellData {
	let title: String
	let subTitle: String
	let mainText: String
	let endingText: String
	
	init(title: String, subTitle: String, mainText: String, endingText: String) {
		self.title = title
		self.subTitle = subTitle
		self.mainText = mainText
		self.endingText = endingText
	}
}

class RosarySubMysteryTableViewCell: UITableViewCell {
	
	let contentInsetView = UIView()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf24
		label.textColor = Color.OceanBlue
		label.textAlignment = .left
		return label
	}()
	
	let subTitleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.f16
		label.textColor = Color.CrimsonRed
		label.textAlignment = .left
		label.numberOfLines = 0
		return label
	}()
	
	let mainTextLabel: Label = {
		let label = Label()
		label.font = Font.f16
		label.textColor = Color.Black
		label.textAlignment = .left
		label.numberOfLines = 0
		label.textAttributes = PredefinedTextAttributes.Paragraph
		return label
	}()
	
	let listOfPrayersLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf16
		label.textColor = Color.OceanBlue
		label.textAlignment = .left
		label.text = "주님의 기도, 성모송(열 번), 영광송, 구원의 기도"
		label.numberOfLines = 0
		return label
	}()
	
	let endingTextLabel: Label = {
		let label = Label()
		label.font = Font.f16
		label.textColor = Color.Black
		label.textAlignment = .left
		label.numberOfLines = 0
		label.textAttributes = PredefinedTextAttributes.Paragraph
		return label
	}()
	
	var rosarySubMysteryTableCellData: RosarySubMysteryTableCellData?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		backgroundColor = Color.White
		contentView.backgroundColor = Color.White
		
		contentView.addSubview(contentInsetView)
		
		contentInsetView.addSubview(titleLabel)
		contentInsetView.addSubview(subTitleLabel)
		contentInsetView.addSubview(mainTextLabel)
		contentInsetView.addSubview(listOfPrayersLabel)
		contentInsetView.addSubview(endingTextLabel)
		
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
		
		subTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(titleLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		mainTextLabel.snp.makeConstraints { (make) in
			make.top.equalTo(subTitleLabel.snp.bottom).offset(Spacing.s16)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		listOfPrayersLabel.snp.makeConstraints { (make) in
			make.top.equalTo(mainTextLabel.snp.bottom).offset(Spacing.s16)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		endingTextLabel.snp.makeConstraints { (make) in
			make.top.equalTo(listOfPrayersLabel.snp.bottom).offset(Spacing.s16)
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

extension RosarySubMysteryTableViewCell: CellUpdatable {
	typealias CellData = RosarySubMysteryTableCellData
	
	func update(withCellData cellData: CellData) {
		rosarySubMysteryTableCellData = cellData
		
		titleLabel.text = cellData.title
		subTitleLabel.text = cellData.subTitle
		mainTextLabel.text = cellData.mainText
		endingTextLabel.text = cellData.endingText
	}
}



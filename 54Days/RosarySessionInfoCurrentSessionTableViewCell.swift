import UIKit
import SnapKit

class RosarySessionInfoCurrentSessionCellData {
	let periodSummary: String
	let petitionSummary: String
	
	init(periodSummary: String, petitionSummary: String) {
		self.periodSummary = periodSummary
		self.petitionSummary = petitionSummary
	}
}

class RosarySessionInfoCurrentSessionTableViewCell: UITableViewCell {
	
	let topBorderView: UIView = {
		let view = UIView()
		view.backgroundColor = Color.Divider.Default
		return view
	}()
	
	let periodSummaryTitleLabel: Label = {
		let label = Label()
		label.font = Font.bf14
		label.textColor = Color.StarDust
		label.text = "묵주기도 기간"
		return label
	}()
	
	let periodSummaryLabel: Label = {
		let label = Label()
		label.font = Font.f16
		label.textColor = Color.Black
		return label
	}()
	
	let petitionSummaryTitleLabel: Label = {
		let label = Label()
		label.font = Font.bf14
		label.textColor = Color.StarDust
		label.text = "청원내용"
		return label
	}()
	
	let petitionSummaryLabel: Label = {
		let label = Label()
		label.font = Font.f16
		label.textColor = Color.Black
		label.numberOfLines = 0
		return label
	}()
	
	var cellData: RosarySessionInfoCurrentSessionCellData?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		contentView.backgroundColor = Color.White
		
		contentView.addSubview(topBorderView)
		contentView.addSubview(periodSummaryTitleLabel)
		contentView.addSubview(periodSummaryLabel)
		contentView.addSubview(petitionSummaryTitleLabel)
		contentView.addSubview(petitionSummaryLabel)
		
		topBorderView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.height.equalTo(2.0)
		}
		
		periodSummaryTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(topBorderView.snp.bottom).offset(Spacing.s16)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
		}
		
		periodSummaryLabel.snp.makeConstraints { (make) in
			make.top.equalTo(periodSummaryTitleLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
		}
		
		petitionSummaryTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(periodSummaryLabel.snp.bottom).offset(Spacing.s12)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
		}
		
		petitionSummaryLabel.snp.makeConstraints { (make) in
			make.top.equalTo(petitionSummaryTitleLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalToSuperview().offset(-Spacing.s16)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension RosarySessionInfoCurrentSessionTableViewCell: CellUpdatable {
	typealias CellData = RosarySessionInfoCurrentSessionCellData
	
	func update(withCellData cellData: CellData) {
		self.cellData = cellData
		
		periodSummaryLabel.text = cellData.periodSummary
		petitionSummaryLabel.text = cellData.petitionSummary
	}
}


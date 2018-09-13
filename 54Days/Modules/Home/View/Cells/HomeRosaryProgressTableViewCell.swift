import UIKit
import SnapKit

class HomeRosaryProgressCellData {
	let currentDateText: String
	let progressDescription: NSAttributedString
	let numberOfDaysPassed: Int

	init(currentDateText: String,
		 progressDescription: NSAttributedString,
		 numberOfDaysPassed: Int) {
		self.currentDateText = currentDateText
		self.progressDescription = progressDescription
		self.numberOfDaysPassed = numberOfDaysPassed
	}
}

class HomeRosaryProgressTableViewCell: UITableViewCell {

	let currentDateLabel: Label = {
		let label = Label()
		label.font = Font.bf20
		label.textColor = Color.BalticSeaGray
		label.textAlignment = .left
		return label
	}()

	let progressDescriptionLabel: Label = {
		let label = Label()
		label.font = Font.f16
		label.textColor = Color.BalticSeaGray
		label.textAlignment = .left
		label.numberOfLines = 0
		return label
	}()

	let progressBar: ProgressBar = {
		let progressBar = ProgressBar(totalProgress: CGFloat(RosaryConstants.numberOfDaysInPeriod))
		progressBar.foregroundBarColor = Color.StarDust
		progressBar.backgroundBarColor = Color.BackgroundGray
		return progressBar
	}()

	let underlineView: UIView = {
		let view = UIView()
		view.backgroundColor = Color.BackgroundGray
		return view
	}()

	var prayerInfoCellData: HomeRosaryProgressCellData?

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		backgroundColor = Color.White

		contentView.addSubview(currentDateLabel)
		contentView.addSubview(progressDescriptionLabel)
		contentView.addSubview(progressBar)
		contentView.addSubview(underlineView)

		currentDateLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s16)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
		}

		progressDescriptionLabel.snp.makeConstraints { (make) in
			make.top.equalTo(currentDateLabel.snp.bottom).offset(Spacing.s12)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
		}

		progressBar.snp.makeConstraints { (make) in
			make.top.equalTo(progressDescriptionLabel.snp.bottom).offset(Spacing.s12)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.height.equalTo(6.0).priority(.high)
		}

		underlineView.snp.makeConstraints { (make) in
			make.top.equalTo(progressBar.snp.bottom).offset(Spacing.s16)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
			make.height.equalTo(1.0)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension HomeRosaryProgressTableViewCell: CellUpdatable {
	typealias CellData = HomeRosaryProgressCellData
	
	func update(withCellData cellData: CellData) {
		prayerInfoCellData = cellData

		currentDateLabel.text = cellData.currentDateText
		progressDescriptionLabel.attributedText = cellData.progressDescription
		progressBar.setProgress(cellData.numberOfDaysPassed, animated: true)
	}
}

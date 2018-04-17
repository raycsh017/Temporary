import UIKit
import SnapKit

class HomeCurrentRosaryInfoCellData {
	let todaysDateText: String
	let progressDescription: NSAttributedString
	let numberOfDaysPassed: Int
	
	init(todaysDateText: String, progressDescription: NSAttributedString, numberOfDaysPassed: Int) {
		self.todaysDateText = todaysDateText
		self.progressDescription = progressDescription
		self.numberOfDaysPassed = numberOfDaysPassed
	}
}

class HomeCurrentRosaryInfoTableViewCell: UITableViewCell {
	
	let dateLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf20
		label.textColor = Color.BalticSeaGray
		label.textAlignment = .left
		return label
	}()
	
	let infoLabel: UILabel = {
		let label = UILabel()
		label.font = Font.f16
		label.textColor = Color.BalticSeaGray
		label.textAlignment = .left
		label.numberOfLines = 0
		return label
	}()
	
	let underlineView: UIView = {
		let view = UIView()
		view.backgroundColor = Color.BackgroundGray
		return view
	}()
	
	let progressBar: ProgressBar = {
		let progressBar = ProgressBar(totalProgress: CGFloat(RosaryConstants.numberOfDaysInPeriod))
		progressBar.foregroundBarColor = Color.RosaryRed
		progressBar.backgroundBarColor = Color.SilverSandGray
		return progressBar
	}()
	
	var prayerInfoCellData: HomeCurrentRosaryInfoCellData?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		backgroundColor = Color.White
		contentView.backgroundColor = Color.White
		
		contentView.addSubview(dateLabel)
		contentView.addSubview(infoLabel)
		contentView.addSubview(progressBar)
		contentView.addSubview(underlineView)
		
		dateLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s12)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
		}
		
		infoLabel.snp.makeConstraints { (make) in
			make.top.equalTo(dateLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
		}
		
		let progressBarHeight: CGFloat = 8.0
		
		progressBar.snp.makeConstraints { (make) in
			make.top.equalTo(infoLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.height.equalTo(progressBarHeight)
		}
		
		let underlineThickness: CGFloat = 1.0
		
		underlineView.snp.makeConstraints { (make) in
			make.top.equalTo(progressBar.snp.bottom).offset(Spacing.s12)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
			make.height.equalTo(underlineThickness)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension HomeCurrentRosaryInfoTableViewCell: CellUpdatable {
	typealias CellData = HomeCurrentRosaryInfoCellData
	
	func update(withCellData cellData: CellData) {
		prayerInfoCellData = cellData
		
		dateLabel.text = cellData.todaysDateText
		infoLabel.attributedText = cellData.progressDescription
		progressBar.setProgress(cellData.numberOfDaysPassed, animated: true)
	}
}

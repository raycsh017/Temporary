import UIKit
import SnapKit

class HomeRosaryProgressCellData {
	let startDateText: String
	let endDateText: String
	let currentDateText: String
	let progressDescription: NSAttributedString
	let numberOfDaysPassed: Int
	
	init(startDateText: String,
		 endDateText: String,
		 currentDateText: String,
		 progressDescription: NSAttributedString,
		 numberOfDaysPassed: Int) {
		self.startDateText = startDateText
		self.endDateText = endDateText
		self.currentDateText = currentDateText
		self.progressDescription = progressDescription
		self.numberOfDaysPassed = numberOfDaysPassed
	}
}

class HomeRosaryProgressTableViewCell: UITableViewCell {

	let startAndEndDateContentView = UIView()

	let startDateCardView: UIView = {
		let view = UIView()
		view.backgroundColor = Color.White
		view.applyShadow()
		view.applyCornerRadius()
		return view
	}()

	let startDateCenteringView = UIView()
	
	let startDateHeaderLabel: Label = {
		let label = Label()
		label.font = Font.f12
		label.textColor = Color.Text.Header
		label.textAlignment = .center
		label.text = "시작"
		return label
	}()
	
	let startDateBodyLabel: Label = {
		let label = Label()
		label.font = Font.bf14
		label.textColor = Color.Text.Body
		label.textAlignment = .center
		label.text = "-"
		return label
	}()
	
	let rightChevronImageView: ImageView = {
		let imageView = ImageView()
		imageView.image = UIImage(named: "ic_chevron_right")?.withRenderingMode(.alwaysTemplate)
		imageView.contentMode = .scaleAspectFit
		imageView.tintColor = Color.StarDust
		return imageView
	}()
	
	let endDateCardView: UIView = {
		let view = UIView()
		view.backgroundColor = Color.White
		view.applyShadow()
		view.applyCornerRadius()
		return view
	}()
	
	let endDateCenteringView = UIView()

	let endDateHeaderLabel: Label = {
		let label = Label()
		label.font = Font.f12
		label.textColor = Color.Text.Header
		label.textAlignment = .center
		label.text = "끝"
		return label
	}()
	
	let endDateBodyLabel: Label = {
		let label = Label()
		label.font = Font.bf14
		label.textColor = Color.Text.Body
		label.textAlignment = .center
		label.text = "-"
		return label
	}()
	
	let currentProgressContentView = UIView()
	
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
		contentView.backgroundColor = Color.White

		contentView.addSubview(startAndEndDateContentView)
		contentView.addSubview(currentProgressContentView)

		startAndEndDateContentView.addSubview(startDateCardView)
		startAndEndDateContentView.addSubview(rightChevronImageView)
		startAndEndDateContentView.addSubview(endDateCardView)

		startDateCardView.addSubview(startDateCenteringView)

		startDateCenteringView.addSubview(startDateHeaderLabel)
		startDateCenteringView.addSubview(startDateBodyLabel)

		endDateCardView.addSubview(endDateCenteringView)

		endDateCenteringView.addSubview(endDateHeaderLabel)
		endDateCenteringView.addSubview(endDateBodyLabel)
		
		currentProgressContentView.addSubview(currentDateLabel)
		currentProgressContentView.addSubview(progressDescriptionLabel)
		currentProgressContentView.addSubview(progressBar)
		currentProgressContentView.addSubview(underlineView)

		startAndEndDateContentView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s16)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
		}
		
		startDateCardView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.bottom.equalToSuperview()
			make.width.equalTo(endDateCardView)
			make.height.equalTo(68.0)
		}
		
		startDateCenteringView.snp.makeConstraints { (make) in
			make.centerX.equalToSuperview()
			make.centerY.equalToSuperview()
		}
		
		startDateHeaderLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		startDateBodyLabel.snp.makeConstraints { (make) in
			make.top.equalTo(startDateHeaderLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		rightChevronImageView.snp.makeConstraints { (make) in
			make.left.equalTo(startDateCardView.snp.right).offset(Spacing.s20)
			make.right.equalTo(endDateCardView.snp.left).offset(-Spacing.s20)
			make.centerY.equalToSuperview()
			make.size.equalTo(CGSize(width: 24.0, height: 24.0))
		}
		
		endDateCardView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
			make.height.equalTo(68.0)
		}
		
		endDateCenteringView.snp.makeConstraints { (make) in
			make.centerX.equalToSuperview()
			make.centerY.equalToSuperview()
		}
		
		endDateHeaderLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		endDateBodyLabel.snp.makeConstraints { (make) in
			make.top.equalTo(endDateHeaderLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		currentProgressContentView.snp.makeConstraints { (make) in
			make.top.equalTo(startAndEndDateContentView.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
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
		
		startDateBodyLabel.text = cellData.startDateText
		endDateBodyLabel.text = cellData.endDateText
		currentDateLabel.text = cellData.currentDateText
		progressDescriptionLabel.attributedText = cellData.progressDescription
		progressBar.setProgress(cellData.numberOfDaysPassed, animated: true)
	}
}

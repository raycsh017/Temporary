import UIKit
import SnapKit

class HomeRosaryProgressCellData {
	let currentDateText: String
	let progressDescription: NSAttributedString
	let progressBarColor: UIColor
	let rosaryProgress: Int

	init(currentDateText: String,
		 progressDescription: NSAttributedString,
		 progressBarColor: UIColor,
		 rosaryProgress: Int) {
		self.currentDateText = currentDateText
		self.progressDescription = progressDescription
		self.progressBarColor = progressBarColor
		self.rosaryProgress = rosaryProgress
	}
}

protocol HomeRosaryProgressTableViewCellDelegate: class {
	func homeRosaryProgressTableViewCellDidTapCurrentRosaryPeriodCTA(_ cell: HomeRosaryProgressTableViewCell)
	func HomeRosaryProgressTableViewCellDidTapSetNewRosaryPeriodCTA(_ cell: HomeRosaryProgressTableViewCell)
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

	let ctaStackView: UIStackView = {
		let stackView = UIStackView(frame: CGRect.zero)
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .fillEqually
		stackView.spacing = CGFloat(Spacing.s16)
		return stackView
	}()

	lazy var currentRosaryPeriodCTAButton: Button = {
		let button = Button(frame: CGRect.zero)
		let attributedText = "진행중인 묵주기도".attributed(withFont: Font.bf16, textColor: Color.Button.Dark)
		button.setAttributedTitle(attributedText, for: .normal)
		button.backgroundColor = Color.White
		button.applyShadow()
		button.applyCornerRadius()
		button.addTarget(self, action: #selector(onCurrentRosaryPeriodCTAButtonTap(_:)), for: .touchUpInside)
		return button
	}()

	lazy var setNewRosaryPeriodCTAButton: Button = {
		let button = Button(frame: CGRect.zero)
		let attributedText = "묵주기도 기간 수정".attributed(withFont: Font.bf16, textColor: Color.Button.Dark)
		button.setAttributedTitle(attributedText, for: .normal)
		button.backgroundColor = Color.White
		button.applyShadow()
		button.applyCornerRadius()
		button.addTarget(self, action: #selector(onSetNewRosaryPeriodCTAButtonTap(_:)), for: .touchUpInside)
		return button
	}()

	let underlineView: UIView = {
		let view = UIView()
		view.backgroundColor = Color.BackgroundGray
		return view
	}()

	weak var delegate: HomeRosaryProgressTableViewCellDelegate?

	var prayerInfoCellData: HomeRosaryProgressCellData?

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		backgroundColor = Color.White

		contentView.addSubview(currentDateLabel)
		contentView.addSubview(progressDescriptionLabel)
		contentView.addSubview(progressBar)
		contentView.addSubview(underlineView)
		contentView.addSubview(ctaStackView)

		ctaStackView.addArrangedSubview(currentRosaryPeriodCTAButton)
		ctaStackView.addArrangedSubview(setNewRosaryPeriodCTAButton)

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

		ctaStackView.snp.makeConstraints { (make) in
			make.top.equalTo(progressBar.snp.bottom).offset(Spacing.s20)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.height.equalTo(Button.suggestedHeight)
		}

		underlineView.snp.makeConstraints { (make) in
			make.top.equalTo(ctaStackView.snp.bottom).offset(Spacing.s20).priority(.high)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
			make.height.equalTo(1.0)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc func onCurrentRosaryPeriodCTAButtonTap(_ sender: Any) {
		delegate?.homeRosaryProgressTableViewCellDidTapCurrentRosaryPeriodCTA(self)
	}

	@objc func onSetNewRosaryPeriodCTAButtonTap(_ sender: Any) {
		delegate?.HomeRosaryProgressTableViewCellDidTapSetNewRosaryPeriodCTA(self)
	}
}

extension HomeRosaryProgressTableViewCell: CellUpdatable {
	typealias CellData = HomeRosaryProgressCellData

	func update(withCellData cellData: CellData) {
		prayerInfoCellData = cellData

		currentDateLabel.text = cellData.currentDateText
		progressDescriptionLabel.attributedText = cellData.progressDescription
		progressBar.foregroundBarColor = cellData.progressBarColor
		progressBar.setProgress(cellData.rosaryProgress, animated: true)
	}
}

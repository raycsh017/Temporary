import UIKit
import SnapKit

class RosaryPeriodInfoPetitionDescriptionViewData {
	let petitionDescriptionHeader: String?
	let petitionDescription: String?
	let startDateText: String?
	let endDateText: String?

	init(petitionDescriptionHeader: String?, petitionDescription: String?, startDateText: String?, endDateText: String?) {
		self.petitionDescriptionHeader = petitionDescriptionHeader
		self.petitionDescription = petitionDescription
		self.startDateText = startDateText
		self.endDateText = endDateText
	}
}

class RosaryPeriodInfoPetitionDescriptionView: UIView {

	let contentCenterView = UIView()

	let headerLabel: Label = {
		let label = Label()
		label.font = Font.bf24
		label.textColor = Color.Black
		return label
	}()

	let bodyLabel: Label = {
		let label = Label()
		label.font = Font.f16
		label.textColor = Color.Black
		label.numberOfLines = 0
		return label
	}()

	let startDateLabel: Label = {
		let label = Label()
		label.font = Font.bf14
		label.textColor = Color.Black
		label.textAlignment = .right
		return label
	}()

	let endDateLabel: Label = {
		let label = Label()
		label.font = Font.bf14
		label.textColor = Color.Black
		label.textAlignment = .right
		return label
	}()

	var viewData: RosaryPeriodInfoPetitionDescriptionViewData?

	override init(frame: CGRect) {
		super.init(frame: frame)

		addSubview(contentCenterView)

		contentCenterView.addSubview(headerLabel)
		contentCenterView.addSubview(bodyLabel)
		contentCenterView.addSubview(startDateLabel)
		contentCenterView.addSubview(endDateLabel)

		contentCenterView.snp.makeConstraints { (make) in
			make.top.greaterThanOrEqualToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.lessThanOrEqualToSuperview()
			make.centerY.equalToSuperview()
		}

		headerLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().inset(Spacing.s16)
		}

		bodyLabel.snp.makeConstraints { (make) in
			make.top.equalTo(headerLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().inset(Spacing.s16)
		}
		
		startDateLabel.snp.makeConstraints { (make) in
			make.top.equalTo(bodyLabel.snp.bottom).offset(Spacing.s24)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
		}
		
		endDateLabel.snp.makeConstraints { (make) in
			make.top.equalTo(startDateLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalToSuperview()
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

extension RosaryPeriodInfoPetitionDescriptionView {
	func update(withViewData viewData: RosaryPeriodInfoPetitionDescriptionViewData) {
		self.viewData = viewData

		headerLabel.text = viewData.petitionDescriptionHeader
		bodyLabel.text = viewData.petitionDescription
		startDateLabel.text = viewData.startDateText
		endDateLabel.text = viewData.endDateText
	}
}

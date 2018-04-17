import Foundation
import UIKit
import SnapKit

protocol RosaryFormModalViewDelegate: class {
	func rosaryFormModalViewDidShow(_ modalView: RosaryFormModalView)
	func rosaryFormModalViewDidTapConfirm(_ modalView: RosaryFormModalView)
	func rosaryFormModalView(_ modalView: RosaryFormModalView, didEditPetitionSummary petitionSummary: String?)
	func rosaryFormModalView(_ modalView: RosaryFormModalView, didChangeStartDate startDate: Date)
}

class RosaryFormModalView: ModalView {

	private let kTextViewHeight: CGFloat = 150.0
	private let kTextFieldHeight: CGFloat = 36.0
	private let kButtonHeight: CGFloat = 48.0
	
	private let kKeyboardAnimationDuration: Double = 0.3
	
	let formAreaView = UIView()
	
	let instructionLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf20
		label.textColor = Color.Black
		label.text = "청원 제목과 묵주기도 시작일을\n정해주세요!"
		label.numberOfLines = 0
		return label
	}()
	
	let petitionSummarySectionTitleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.StarDust
		label.text = "청원제목"
		return label
	}()
	
	let petitionSummaryTextContainerView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = CornerRadius.cr4
		view.layer.borderColor = Color.Platinum.cgColor
		view.layer.borderWidth = 2.0
		return view
	}()
	
	let petitionSummaryTextView: UITextView = {
		let textView = UITextView()
		textView.font = Font.f14
		textView.textColor = Color.Black
		textView.tintColor = Color.Black
		textView.autocorrectionType = .no
		return textView
	}()
	
	let startDateSectionTitleLabel: UILabel = {
		let label = UILabel()
		label.font = Font.bf14
		label.textColor = Color.StarDust
		label.text = "묵주기도 시작일"
		return label
	}()
	
	let startDateTextFieldContainerView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = CornerRadius.cr4
		view.layer.borderColor = Color.Platinum.cgColor
		view.layer.borderWidth = 2.0
		return view
	}()
	
	lazy var startDateTextField: UITextField = {
		let textField = UITextField()
		textField.font = Font.f14
		textField.textColor = Color.Black
		textField.tintColor = Color.Black
		textField.autocorrectionType = .no
		textField.inputView = self.datePicker
		return textField
	}()
	
	lazy var datePicker: UIDatePicker = {
		let datePicker = UIDatePicker()
		datePicker.datePickerMode = .date
		datePicker.addTarget(self, action: #selector(onDatePickerValueChanged(_:)), for: .valueChanged)
		return datePicker
	}()
	
	let buttonStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .fillEqually
		stackView.spacing = CGFloat(Spacing.s16)
		return stackView
	}()
	
	lazy var confirmButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = Color.Aquamarine
		button.layer.cornerRadius = self.kButtonHeight / 2
		button.setTitle("확인", for: .normal)
		button.addTarget(self, action: #selector(onConfirmButtonTapped(_:)), for: .touchUpInside)
		return button
	}()
	
	lazy var cancelButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = Color.SilverSandGray
		button.layer.cornerRadius = self.kButtonHeight / 2
		button.setTitle("취소", for: .normal)
		button.addTarget(self, action: #selector(onCancelButtonTapped(_:)), for: .touchUpInside)
		return button
	}()
	
	weak var delegate: RosaryFormModalViewDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentSafeAreaView.addSubview(formAreaView)
		contentSafeAreaView.addSubview(buttonStackView)
		
		formAreaView.addSubview(instructionLabel)
		formAreaView.addSubview(petitionSummarySectionTitleLabel)
		formAreaView.addSubview(petitionSummaryTextContainerView)
		formAreaView.addSubview(startDateSectionTitleLabel)
		formAreaView.addSubview(startDateTextFieldContainerView)
		
		petitionSummaryTextContainerView.addSubview(petitionSummaryTextView)
		startDateTextFieldContainerView.addSubview(startDateTextField)
		
		buttonStackView.addArrangedSubview(cancelButton)
		buttonStackView.addArrangedSubview(confirmButton)
		
		formAreaView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s24)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
		}
		
		instructionLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		petitionSummarySectionTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(instructionLabel.snp.bottom).offset(Spacing.s16)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		petitionSummaryTextContainerView.snp.makeConstraints { (make) in
			make.top.equalTo(petitionSummarySectionTitleLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.height.equalTo(kTextViewHeight)
		}
		
		petitionSummaryTextView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview().inset(UIEdgeInsets.make(with: Spacing.s8))
		}
		
		startDateSectionTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(petitionSummaryTextView.snp.bottom).offset(Spacing.s16)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		startDateTextFieldContainerView.snp.makeConstraints { (make) in
			make.top.equalTo(startDateSectionTitleLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
			make.height.equalTo(kTextFieldHeight)
		}
		
		startDateTextField.snp.makeConstraints { (make) in
			make.edges.equalToSuperview().inset(UIEdgeInsets.make(with: Spacing.s8))
		}
		
		buttonStackView.setContentHuggingPriority(.required, for: .vertical)
		buttonStackView.snp.makeConstraints { (make) in
			make.top.equalTo(formAreaView.snp.bottom).offset(Spacing.s24)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalToSuperview().offset(-Spacing.s16)
			make.height.equalTo(kButtonHeight)
		}
		
		setupGestureRecognizers()
		setupNotificationObservers()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func show() {
		super.show()
		delegate?.rosaryFormModalViewDidShow(self)
	}
	
	private func setupGestureRecognizers() {
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onFormAreaTapped(_:)))
		formAreaView.addGestureRecognizer(tapGestureRecognizer)
	}
	
	private func setupNotificationObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(adjustFrameOnKeyboardShowEvent(_:)), name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(adjustFrameOnKeyboardHideEvent(_:)), name: .UIKeyboardWillHide, object: nil)
	}
	
	@objc
	func onFormAreaTapped(_ sender: Any) {
		endEditing(true)
	}
	
	@objc
	func onConfirmButtonTapped(_ sender: Any) {
		delegate?.rosaryFormModalViewDidTapConfirm(self)
		dismiss()
	}
	
	@objc
	func onCancelButtonTapped(_ sender: Any) {
		dismiss()
	}
	
	@objc
	func onDatePickerValueChanged(_ sender: Any) {
		guard let datePicker = sender as? UIDatePicker else {
			return
		}
		
		delegate?.rosaryFormModalView(self, didChangeStartDate: datePicker.date)
	}
	
	@objc
	func adjustFrameOnKeyboardShowEvent(_ notification: Notification) {
		guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
			return
		}
		
		let adjustedContentSafeAreaBottomOffset = keyboardFrame.height
		contentSafeAreaBottomConstraint?.update(offset: -adjustedContentSafeAreaBottomOffset)
		
		UIView.animate(withDuration: kKeyboardAnimationDuration) {
			self.layoutIfNeeded()
		}
	}
	
	@objc
	func adjustFrameOnKeyboardHideEvent(_ notification: Notification) {
		let adjustedContentSafeAreaBottomOffset = kWindowSafeAreaInset.bottom
		contentSafeAreaBottomConstraint?.update(offset: -adjustedContentSafeAreaBottomOffset)
		
		UIView.animate(withDuration: kKeyboardAnimationDuration) {
			self.layoutIfNeeded()
		}
	}
}

extension RosaryFormModalView: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		let petitionSummary = textView.text
		delegate?.rosaryFormModalView(self, didEditPetitionSummary: petitionSummary)
	}
}

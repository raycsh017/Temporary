import UIKit
import SnapKit

class RosaryFormViewController: TableViewController {

	let footerView = UIView()

	let footerContentView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .fillEqually
		stackView.spacing = CGFloat(Spacing.s12)
		return stackView
	}()

	lazy var confirmButton: Button = {
		let button = Button()
		button.setTitle("확인", for: .normal)
		button.backgroundColor = Color.Button.Confirm
		button.layer.cornerRadius = CornerRadius.Button
		button.addTarget(self, action: #selector(onConfirmButtonTap(_:)), for: .touchUpInside)
		return button
	}()

	lazy var cancelButton: Button = {
		let button = Button()
		button.setTitle("취소", for: .normal)
		button.setTitleColor(Color.Button.Cancel, for: .normal)
		button.layer.cornerRadius = CornerRadius.Button
		button.addTarget(self, action: #selector(onCancelButtonTap(_:)), for: .touchUpInside)
		return button
	}()

	let viewModel = RosaryFormViewModel()

	override init() {
		super.init()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.showsVerticalScrollIndicator = false

		setupNavigationBar(withTitle: "새 묵주기도", leftButtonType: .x, rightButtonType: nil)
		adjustContentInsetOnKeyboardEvents = true
		dismissKeyboardOnScroll = true
		endEditingOnTap = true

		// Do any additional setup after loading the view.
		footerView.addSubview(footerContentView)
		footerContentView.addArrangedSubview(cancelButton)
		footerContentView.addArrangedSubview(confirmButton)

		footerContentView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s16)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().inset(Spacing.s16).priority(.high)
			make.bottom.equalToSuperview().inset(Spacing.s16).priority(.high)
		}

		cancelButton.snp.makeConstraints { (make) in
			make.height.equalTo(Button.suggestedHeight)
		}

		confirmButton.snp.makeConstraints { (make) in
			make.height.equalTo(Button.suggestedHeight)
		}

		setFooterView(footerView, fixedToBottom: true)

		reloadData(withCellConfigurators: viewModel.cellConfigurators())
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) {
		if let cell = reusableCell as? RosaryFormPetitionFieldTableViewCell {
			cell.delegate = self
		} else if let cell = reusableCell as? RosaryFormDateFieldTableViewCell {
			cell.delegate = self
		}
	}

	@objc func onConfirmButtonTap(_ sender: Any) {
		viewModel.saveForm {
			self.dismiss(animated: true, completion: nil)
		}
	}

	@objc func onCancelButtonTap(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
}

extension RosaryFormViewController: RosaryFormPetitionFieldTableViewCellDelegate {
	func rosaryFormPetitionFieldTableViewCell(_ cell: RosaryFormPetitionFieldTableViewCell, didEditText text: String) {
		viewModel.setRosaryPetitionText(text)
	}
}

extension RosaryFormViewController: RosaryFormDateFieldTableViewCellDelegate {
	func rosaryFormDateFieldTableViewCell(_ cell: RosaryFormDateFieldTableViewCell, didChangeStartDate date: Date) {
		viewModel.setRosaryStartDate(date)

		cell.startDateTextField.text = viewModel.rosaryStartDateText
		cell.endDateTextField.text = viewModel.rosaryEndDateText
	}
}

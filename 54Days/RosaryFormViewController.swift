import UIKit
import SnapKit

protocol RosaryFormViewControllerDelegate: class {
	func rosaryFormViewControllerDidEditForm(_ viewController: RosaryFormViewController)
}

class RosaryFormViewController: TableViewController {

	let footerView = UIView()

	lazy var confirmButton: Button = {
		let button = Button()
		let attributedText = "확인".attributed(withFont: Font.f16, textColor: Color.Button.Confirm)
		button.setAttributedTitle(attributedText, for: .normal)
		button.backgroundColor = Color.White
		button.applyShadow()
		button.applyCornerRadius()
		button.addTarget(self, action: #selector(onConfirmButtonTap(_:)), for: .touchUpInside)
		return button
	}()

	weak var delegate: RosaryFormViewControllerDelegate?
	let viewModel: RosaryFormViewModel

	init(viewModel: RosaryFormViewModel, presentationType: PresentationType) {
		self.viewModel = viewModel
		super.init(presentationType: presentationType)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.showsVerticalScrollIndicator = false

		updateNavigationBar(title: "묵주기도 설정")

		adjustContentInsetOnKeyboardEvents = true
		dismissKeyboardOnScroll = true
		endEditingOnTap = true

		// Do any additional setup after loading the view.
		footerView.addSubview(confirmButton)

		confirmButton.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s16)
			make.centerX.equalToSuperview()
			make.bottom.equalToSuperview().offset(-Spacing.s16)
			make.width.equalTo(Button.suggestedWidth)
			make.height.equalTo(Button.suggestedHeight)
		}

		setFooterView(footerView, fixedToBottom: true)

		viewModel.getCellConfigurators { (cellConfigurators) in
			self.reloadData(withCellConfigurators: cellConfigurators)
		}
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

	override func onLeftNavigationButtonTap(_ sender: Any) {
		if viewModel.formDidChange {
			let alertController = UIAlertController(title: "잠깐!", message: "묵주기도 내용이 바뀌었네요. 저장할까요?", preferredStyle: .alert)
			alertController.addAction(UIAlertAction(title: "저장", style: .default, handler: { (action) in
				self.viewModel.saveForm {
					self.delegate?.rosaryFormViewControllerDidEditForm(self)
					self.routeBack()
				}
			}))
			alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
			present(alertController, animated: true, completion: nil)
		} else {
			routeBack()
		}
	}

	@objc func onConfirmButtonTap(_ sender: Any) {
		viewModel.saveForm {
			self.delegate?.rosaryFormViewControllerDidEditForm(self)
			self.dismiss(animated: true, completion: nil)
		}
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

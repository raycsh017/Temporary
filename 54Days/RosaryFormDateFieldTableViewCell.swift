import UIKit
import SnapKit

class RosaryFormDateFieldCellData {
	let rosaryStartDate: Date
	let startDateText: String?
	let endDateText: String?

	init(rosaryStartDate: Date, startDateText: String?, endDateText: String?) {
		self.rosaryStartDate = rosaryStartDate
		self.startDateText = startDateText
		self.endDateText = endDateText
	}
}

protocol RosaryFormDateFieldTableViewCellDelegate: class {
	func rosaryFormDateFieldTableViewCell(_ cell: RosaryFormDateFieldTableViewCell, didChangeStartDate date: Date)
}

class RosaryFormDateFieldTableViewCell: UITableViewCell {
	let startDateHeaderLabel: Label = {
		let label = Label()
		label.font = Font.bf14
		label.textColor = Color.Form.Header
		label.text = "시작일"
		return label
	}()

	lazy var startDateTextField: TextField = {
		let textField = TextField(frame: CGRect.zero)
		textField.font = Font.f14
		textField.textColor = Color.Form.TextFieldText
		textField.tintColor = Color.Form.TextFieldText
		textField.layer.cornerRadius = CornerRadius.cr4
		textField.layer.borderColor = Color.Border.TextField.cgColor
		textField.layer.borderWidth = 1.0
		textField.autocorrectionType = .no
		textField.inputAccessoryView = self.toolBar
		textField.inputView = self.datePicker
		return textField
	}()

	let endDateHeaderLabel: Label = {
		let label = Label()
		label.font = Font.bf14
		label.textColor = Color.Form.Header
		label.text = "마지막일"
		label.alpha = 0.5
		return label
	}()

	lazy var endDateTextField: TextField = {
		let textField = TextField(frame: CGRect.zero)
		textField.font = Font.f14
		textField.textColor = Color.Form.TextFieldText
		textField.tintColor = Color.Form.TextFieldText
		textField.layer.cornerRadius = CornerRadius.cr4
		textField.layer.borderColor = Color.Border.TextField.cgColor
		textField.layer.borderWidth = 1.0
		textField.isEnabled = false
		textField.alpha = 0.5
		return textField
	}()

	lazy var toolBar: UIToolbar = {
		let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
		let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(onDoneButtonTap(_:)))
		let toolBar = UIToolbar(frame: CGRect.zero)
		toolBar.tintColor = Color.ToolBar.Dark
		toolBar.items = [flexibleSpace, doneButton]
		toolBar.sizeToFit()
		return toolBar
	}()

	lazy var datePicker: UIDatePicker = {
		let datePicker = UIDatePicker()
		datePicker.datePickerMode = .date
		datePicker.addTarget(self, action: #selector(onDatePickerValueChanged(_:)), for: .valueChanged)
		return datePicker
	}()

	weak var delegate: RosaryFormDateFieldTableViewCellDelegate?
	var dateFieldCellData: RosaryFormDateFieldCellData?

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		contentView.addSubview(startDateHeaderLabel)
		contentView.addSubview(startDateTextField)

		contentView.addSubview(endDateHeaderLabel)
		contentView.addSubview(endDateTextField)

		startDateHeaderLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s16)
			make.left.equalTo(startDateTextField.snp.left)
			make.right.equalTo(startDateTextField.snp.right)
		}

		startDateTextField.snp.makeConstraints { (make) in
			make.top.equalTo(startDateHeaderLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.bottom.equalToSuperview()
			make.height.equalTo(TextField.suggestedHeight)
		}
		
		endDateHeaderLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s16)
			make.left.equalTo(endDateTextField.snp.left)
			make.right.equalTo(endDateTextField.snp.right)
		}
		
		endDateTextField.snp.makeConstraints { (make) in
			make.top.equalTo(endDateHeaderLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalTo(startDateTextField.snp.right).offset(Spacing.s16)
			make.right.equalToSuperview().inset(Spacing.s16)
			make.bottom.equalToSuperview()
			make.width.equalTo(startDateTextField.snp.width)
			make.height.equalTo(TextField.suggestedHeight)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc func onDoneButtonTap(_ sender: Any) {
		endEditing(true)
	}

	@objc func onDatePickerValueChanged(_ sender: Any) {
		guard let datePicker = sender as? UIDatePicker else {
			return
		}
		delegate?.rosaryFormDateFieldTableViewCell(self, didChangeStartDate: datePicker.date)
	}
}

extension RosaryFormDateFieldTableViewCell: CellUpdatable {
	typealias CellData = RosaryFormDateFieldCellData

	func update(withCellData cellData: CellData) {
		dateFieldCellData = cellData

		startDateTextField.text = cellData.startDateText
		endDateTextField.text = cellData.endDateText
		datePicker.date = cellData.rosaryStartDate
	}
}

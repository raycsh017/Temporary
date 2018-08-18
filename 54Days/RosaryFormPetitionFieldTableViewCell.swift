import UIKit
import SnapKit

class RosaryFormPetitionFieldCellData {
	let inputText: String?

	init(inputText: String?) {
		self.inputText = inputText
	}
}

protocol RosaryFormPetitionFieldTableViewCellDelegate: class {
	func rosaryFormPetitionFieldTableViewCell(_ cell: RosaryFormPetitionFieldTableViewCell, didEditText text: String)
}

class RosaryFormPetitionFieldTableViewCell: UITableViewCell {
	let headerLabel: Label = {
		let label = Label()
		label.font = Font.bf14
		label.textColor = Color.Form.Header
		label.text = "청원내용"
		return label
	}()

	lazy var inputTextView: TextView = {
		let textView = TextView(frame: CGRect.zero)
		textView.font = Font.f14
		textView.textColor = Color.Form.TextFieldText
		textView.tintColor = Color.Form.TextFieldText
		textView.textContainerInset = UIEdgeInsets(top: 16.0, left: 8.0, bottom: 16.0, right: 8.0)
		textView.layer.cornerRadius = CornerRadius.cr4
		textView.layer.borderColor = Color.Border.TextField.cgColor
		textView.layer.borderWidth = 1.0
		textView.autocorrectionType = .no
		textView.delegate = self
		return textView
	}()

	weak var delegate: RosaryFormPetitionFieldTableViewCellDelegate?
	var petitionFieldCellData: RosaryFormPetitionFieldCellData?

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		contentView.addSubview(headerLabel)
		contentView.addSubview(inputTextView)
		
		headerLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s16)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().inset(Spacing.s16)
		}
		
		inputTextView.snp.makeConstraints { (make) in
			make.top.equalTo(headerLabel.snp.bottom).offset(Spacing.s8)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().inset(Spacing.s16)
			make.bottom.equalToSuperview()
			make.height.equalTo(200.0)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension RosaryFormPetitionFieldTableViewCell: CellUpdatable {
	typealias CellData = RosaryFormPetitionFieldCellData

	func update(withCellData cellData: CellData) {
		petitionFieldCellData = cellData
		
		inputTextView.text = cellData.inputText
	}
}

extension RosaryFormPetitionFieldTableViewCell: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		delegate?.rosaryFormPetitionFieldTableViewCell(self, didEditText: textView.text)
	}
}

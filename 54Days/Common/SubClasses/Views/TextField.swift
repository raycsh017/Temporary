import UIKit
import SnapKit

class TextField: UIView {
	var font: UIFont? {
		didSet {
			textField.font = font
		}
	}
	
	let textField: UITextField = {
		let textField = UITextField()
		textField.textColor = Color.Black
		textField.tintColor = Color.Black
		textField.autocorrectionType = .no
		textField.autocapitalizationType = .none
		return textField
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(textField)
		
		textField.snp.makeConstraints { (make) in
			make.edges.equalToSuperview().inset(UIEdgeInsets.make(with: Spacing.s8))
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

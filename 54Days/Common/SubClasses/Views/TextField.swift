import UIKit
import SnapKit

class TextField: UITextField {
	static let suggestedHeight: CGFloat = 32.0

	private let suggestedTextInset = UIEdgeInsets.make(with: Spacing.s8)
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return UIEdgeInsetsInsetRect(bounds, suggestedTextInset)
	}
	
	override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		return UIEdgeInsetsInsetRect(bounds, suggestedTextInset)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return UIEdgeInsetsInsetRect(bounds, suggestedTextInset)
	}
}

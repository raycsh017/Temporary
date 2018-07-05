import UIKit

class Label: UILabel {
	var textAttributes: TextAttributes? {
		didSet {
			applyTextAttributes()
		}
	}
	
	override var text: String? {
		didSet {
			applyTextAttributes()
		}
	}
	
	func applyTextAttributes() {
		guard let textAttributes = textAttributes else {
			return
		}
		
		let attrString = attributedText ?? NSAttributedString()
		let mutableAttrString = NSMutableAttributedString(attributedString: attrString)
		
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = textAttributes.lineSpacing
		paragraphStyle.paragraphSpacing = textAttributes.paragraphSpacing
		
		mutableAttrString.addAttributes([
			.paragraphStyle: paragraphStyle
		], range: NSMakeRange(0, mutableAttrString.length))
		
		attributedText = mutableAttrString as NSAttributedString
	}
}

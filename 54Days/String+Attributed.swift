import UIKit

extension String {
	func attributed(withFont font: UIFont, textColor: UIColor?) -> NSAttributedString {
		let mutableString = NSMutableAttributedString(string: self)

		var attributes: [NSAttributedStringKey: Any] = [:]
		attributes[.font] = font
		attributes[.foregroundColor] = textColor
		mutableString.setAttributes(attributes, range: NSRange(location: 0, length: count))

		return mutableString
	}
}

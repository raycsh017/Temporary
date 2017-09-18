import UIKit

extension UIView {
	func applyShadow() {
		layer.shadowColor = Color.Black.cgColor
		layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
		layer.shadowRadius = CGFloat(0.5)
		layer.shadowOpacity = Float(0.3)
	}
}

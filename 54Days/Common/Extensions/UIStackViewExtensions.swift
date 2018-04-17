import UIKit

extension UIStackView {
	func removeAllArrangedSubviews() {
		for view in arrangedSubviews {
			removeArrangedSubview(view)
		}
	}
}

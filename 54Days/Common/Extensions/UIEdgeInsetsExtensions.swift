import Foundation
import UIKit

extension UIEdgeInsets {
	static func make(withVerticalInset verticalInset: Int, horizontalInset: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: CGFloat(verticalInset), left: CGFloat(horizontalInset), bottom: CGFloat(verticalInset), right: CGFloat(horizontalInset))
	}
	
	static func make(with value: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: CGFloat(value), left: CGFloat(value), bottom: CGFloat(value), right: CGFloat(value))
	}
}

import Foundation
import UIKit

extension UIEdgeInsets {
	static func make(with value: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: CGFloat(value), left: CGFloat(value), bottom: CGFloat(value), right: CGFloat(value))
	}
}

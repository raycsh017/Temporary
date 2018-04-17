import Foundation
import UIKit

extension UIViewController {
	var topGuide: UIView {
		guard let topLayoutGuide = topLayoutGuide as AnyObject as? UIView else { return UIView() }
		return topLayoutGuide
	}
	
	var bottomGuide: UIView {
		guard let bottomLayoutGuide = bottomLayoutGuide as AnyObject as? UIView else { return UIView() }
		return bottomLayoutGuide
	}
}

import Foundation
import UIKit

extension UIColor{
	class func withRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
		return UIColor(red: (red/255), green: (green/255), blue: (blue/255), alpha: 1)
	}
	
	class func withHex(_ value: Int) -> UIColor{
		let red = CGFloat((value >> 16) & 0xFF) / 255.0
		let green = CGFloat((value >> 8) & 0xFF) / 255.0
		let blue = CGFloat((value) & 0xFF) / 255.0
		let alpha: CGFloat = 1.0
		return UIColor(red: red, green: green, blue: blue, alpha: alpha)
	}
}

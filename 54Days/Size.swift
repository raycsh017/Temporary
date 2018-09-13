import UIKit

struct Size {
	static let Screen = UIScreen.main.bounds.size
	static let StatusBar = UIApplication.shared.statusBarFrame.size
	static let NavigationBar = CGSize(width: UIScreen.main.bounds.width,
									  height: 44.0)
}

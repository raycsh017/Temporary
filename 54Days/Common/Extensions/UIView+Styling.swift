import UIKit

extension UIView {
	@objc func applyShadow() {
		layer.shadowColor = Color.Black.cgColor
		layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
		layer.shadowRadius = CGFloat(0.5)
		layer.shadowOpacity = Float(0.3)
	}

	@objc func applyCornerRadius() {
		layer.cornerRadius = CornerRadius.cr4
	}

	func applyUnderline() {
		let underlineView = UIView()
		underlineView.backgroundColor = Color.BackgroundGray
		
		let underlineThickness: CGFloat = 1.0
		
		addSubview(underlineView)
		underlineView.snp.makeConstraints { (make) in
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
			make.height.equalTo(underlineThickness)
		}
	}
}

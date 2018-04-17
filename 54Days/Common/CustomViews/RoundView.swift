import UIKit
import SnapKit

class RoundView: UIView {
	
	let roundCornerLayer = CAShapeLayer()
	
	var rectCornerRadius: CGFloat = 0.0 {
		didSet { roundCorner() }
	}
	
	var rectCorner: UIRectCorner = [] {
		didSet { roundCorner() }
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		
		roundCorner()
	}
	
	func roundCorner() {
		roundCornerLayer.removeFromSuperlayer()
		
		let radii = CGSize(width: rectCornerRadius, height: rectCornerRadius)
		let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: rectCorner, cornerRadii: radii).cgPath
		roundCornerLayer.path = path
		roundCornerLayer.frame = bounds
		
		layer.mask = roundCornerLayer
	}
}

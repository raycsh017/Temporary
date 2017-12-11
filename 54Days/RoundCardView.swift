import UIKit
import SnapKit

class RoundCardView: UIView {
	
	let shadowView: UIView = {
		let view = UIView()
		view.applyShadow()
		return view
	}()
	
	let cardView: UIView = {
		let view = UIView()
		view.backgroundColor = Color.White
		view.layer.cornerRadius = CornerRadius.cr4
		view.clipsToBounds = true
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(shadowView)
		shadowView.addSubview(cardView)
		
		shadowView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
		
		cardView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func addCardContentView(_ view: UIView) {
		view.removeFromSuperview()
		cardView.addSubview(view)
	}
}

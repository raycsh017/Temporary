import UIKit
import SnapKit

class ModalView: UIView {
	
	private let kMinBackgroundAlpha: CGFloat = 0.0
	private let kMaxBackgroundAlpha: CGFloat = 0.7
	private let kAnimationDuration: Double = 0.4
	
	let kWindowSafeAreaInset: UIEdgeInsets = UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero

	let backgroundView: UIView = {
		let view = UIView()
		view.backgroundColor = Color.Black
		return view
	}()
	
	let contentView: RoundView = {
		let view = RoundView()
		view.backgroundColor = Color.White
		view.rectCornerRadius = CornerRadius.cr32
		view.rectCorner = [.topLeft, .topRight]
		return view
	}()
	
	let contentSafeAreaView = UIView()
	
	var contentSafeAreaBottomConstraint: Constraint?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(backgroundView)
		addSubview(contentView)
		
		contentView.addSubview(contentSafeAreaView)
		
		backgroundView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
		
		contentView.snp.makeConstraints { (make) in
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		contentSafeAreaView.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			contentSafeAreaBottomConstraint = make.bottom.equalToSuperview().constraint
		}
		
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
		backgroundView.addGestureRecognizer(tapGestureRecognizer)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func show() {
		guard let keyWindow = UIApplication.shared.keyWindow else {
			return
		}
		
		keyWindow.addSubview(self)
		
		self.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
		
		contentSafeAreaBottomConstraint?.update(offset: -kWindowSafeAreaInset.bottom)
		
		layoutIfNeeded()
		
		// Animation pre-work
		backgroundView.alpha = kMinBackgroundAlpha
		contentView.transform = CGAffineTransform(translationX: 0, y: bounds.height)
		
		UIView.animate(withDuration: kAnimationDuration) {
			self.backgroundView.alpha = self.kMaxBackgroundAlpha
			self.contentView.transform = CGAffineTransform.identity
		}
	}
	
	@objc
	func dismiss() {
		UIView.animate(withDuration: kAnimationDuration, animations: {
			self.backgroundView.alpha = self.kMinBackgroundAlpha
			self.contentView.transform = CGAffineTransform(translationX: 0, y: self.bounds.height)
		}) { (completed) in
			if completed {
				self.removeFromSuperview()
			}
		}
	}
	
}

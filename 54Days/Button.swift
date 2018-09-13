import UIKit
import SnapKit

class Button: UIButton {
	static let suggestedWidth: CGFloat = 252.0
	static let suggestedHeight: CGFloat = 48.0

	private var savedBackgroundColor: UIColor?
	private var touchAnimator: UIViewPropertyAnimator?

	private var isCircular: Bool = false

	var highlightedColor: UIColor? = Color.Button.State.Highlighted

	override var backgroundColor: UIColor? {
		willSet {
			savedBackgroundColor = backgroundColor
		}
	}

	convenience init(frame: CGRect, circular: Bool) {
		self.init(frame: frame)
		isCircular = circular
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		addTarget(self, action: #selector(onTouchDown(_:)), for: [.touchDown, .touchDragEnter])
		addTarget(self, action: #selector(onTouchUp(_:)), for: [.touchUpInside, .touchDragExit, .touchCancel])
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		if isCircular {
			layer.cornerRadius = max(bounds.width, bounds.height) / 2.0
		}
	}

	override func applyShadow() {
		layer.shadowColor = Color.Black.cgColor
		layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
		layer.shadowRadius = CGFloat(3.0)
		layer.shadowOpacity = Float(0.5)
	}

	override func applyCornerRadius() {
		layer.cornerRadius = CornerRadius.Button.Oval
	}

	@objc func onTouchDown(_ sender: Any) {
		touchAnimator?.stopAnimation(true)
		savedBackgroundColor = backgroundColor
		backgroundColor = highlightedColor
	}

	@objc func onTouchUp(_ sender: Any) {
		touchAnimator = UIViewPropertyAnimator(duration: 0.4, curve: .easeOut, animations: { [weak self] in
			self?.restoreBackgroundColor()
		})
		touchAnimator?.startAnimation()
	}

	private func restoreBackgroundColor() {
		backgroundColor = savedBackgroundColor
	}
}

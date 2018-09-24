import UIKit
import SnapKit

class ProgressBar: UIView {
	private let animationDuration: Double = 0.3

	var totalProgress: CGFloat = 0.0
	var currentProgress: CGFloat = 0.0

	var backgroundBarColor: UIColor? {
		didSet {
			backgroundView.backgroundColor = backgroundBarColor
		}
	}

	var foregroundBarColor: UIColor? {
		didSet {
			foregroundView.backgroundColor = foregroundBarColor
		}
	}

	let backgroundView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = CornerRadius.cr4
		return view
	}()

	let foregroundView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = CornerRadius.cr4
		return view
	}()

	var foregroundViewWidthConstraint: Constraint?

	init(totalProgress: CGFloat) {
		super.init(frame: .zero)

		self.totalProgress = totalProgress

		addSubview(backgroundView)
		addSubview(foregroundView)

		backgroundView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}

		remakeForegroundViewConstraints(withWidthMultiplier: 0)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setProgress(_ progress: Int, animated: Bool) {
		setProgress(CGFloat(progress), animated: animated)
	}

	func setProgress(_ progress: CGFloat, animated: Bool) {
		guard progress <= totalProgress else {
			return
		}

		let progressMultiplier = progress / totalProgress
		remakeForegroundViewConstraints(withWidthMultiplier: progressMultiplier)

		if animated {
			UIView.animate(withDuration: animationDuration) { [weak self] in
				self?.layoutIfNeeded()
			}
		} else {
			layoutIfNeeded()
		}
	}

	private func remakeForegroundViewConstraints(withWidthMultiplier widthMultiplier: CGFloat) {
		foregroundView.snp.remakeConstraints { (make) in
			make.top.left.bottom.equalToSuperview()
			make.width.equalToSuperview().multipliedBy(widthMultiplier)
		}
	}
}

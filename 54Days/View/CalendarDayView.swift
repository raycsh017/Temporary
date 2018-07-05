import UIKit
import SnapKit

class CalendarDayView: UIView {
	
	private let eventIndicatorViewSize = CGSize(width: 4.0, height: 4.0)
	
	let contentCenterView = UIView()
	
	let dayLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		return label
	}()
	
	let eventIndicatorStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.distribution = .equalSpacing
		stackView.spacing = 4.0
		return stackView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(contentCenterView)
		
		contentCenterView.addSubview(dayLabel)
		contentCenterView.addSubview(eventIndicatorStackView)
		
		contentCenterView.snp.makeConstraints { (make) in
			make.centerX.equalToSuperview()
			make.centerY.equalToSuperview()
		}
		
		dayLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		eventIndicatorStackView.snp.makeConstraints { (make) in
			make.top.equalTo(dayLabel.snp.bottom).offset(Spacing.s4)
			make.bottom.equalToSuperview().priority(.high)
			make.centerX.equalToSuperview()
			make.height.equalTo(eventIndicatorViewSize.height)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func updateDayLabel(text: String, textColor: UIColor? = nil) {
		dayLabel.text = text
		dayLabel.textColor = textColor
	}
	
	func showEventIndicators(withColors colors: [UIColor?]) {
		eventIndicatorStackView.removeAllArrangedSubviews()
		
		for color in colors {
			guard color != nil else {
				continue
			}
			
			let eventIndicatorView = UIView()
			eventIndicatorView.backgroundColor = color
			eventIndicatorView.layer.cornerRadius = eventIndicatorViewSize.width / 2
			eventIndicatorStackView.addArrangedSubview(eventIndicatorView)
			
			eventIndicatorView.snp.makeConstraints { (make) in
				make.size.equalTo(eventIndicatorViewSize)
			}
		}
	}
	
	func hideEventIndicators() {
		eventIndicatorStackView.removeAllArrangedSubviews()
	}
}

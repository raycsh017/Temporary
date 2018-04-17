import UIKit
import SnapKit

class CalendarDayView: UIView {
	
	private let eventIndicatorLength: CGFloat = 4.0
	
	let contentStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.distribution = .equalSpacing
		stackView.spacing = 4.0
		return stackView
	}()
	
	let dayLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		return label
	}()
	
	let eventIndicatorStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .equalSpacing
		stackView.spacing = 4.0
		return stackView
	}()
	
	lazy var eventIndicatorView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = self.eventIndicatorLength / 2
		view.backgroundColor = .clear
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(contentStackView)
		
		contentStackView.addArrangedSubview(dayLabel)
		contentStackView.addArrangedSubview(eventIndicatorView)
		
		contentStackView.snp.makeConstraints { (make) in
			make.centerX.equalToSuperview()
			make.centerY.equalToSuperview()
		}
		
		eventIndicatorView.snp.makeConstraints { (make) in
			make.size.equalTo(eventIndicatorLength)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func updateDayLabel(text: String, textColor: UIColor = .black) {
		dayLabel.text = text
		dayLabel.textColor = textColor
	}
	
	func showEventIndicator(withColor color: UIColor) {
		eventIndicatorView.backgroundColor = color
	}
	
	func hideEventIndicator() {
		eventIndicatorView.backgroundColor = .clear
	}
	
}

import UIKit
import SnapKit

class CalendarDayCollectionViewCell: UICollectionViewCell {
	
	static let cellIdentifier = "SwiftyDatesCollectionViewCell"
	
	lazy var dayView: CalendarDayView = {
		let view = CalendarDayView(frame: .zero)
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		
		contentView.addSubview(dayView)
		
		dayView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configureText(_ text: String, withColor textColor: UIColor) {
		dayView.updateDayLabel(text: text, textColor: textColor)
	}
	
}

import UIKit
import SnapKit

protocol CalendarMonthCollectionViewCellDelegate: class {
	func calendarMonthCollectionViewCell(_ cell: CalendarMonthCollectionViewCell, willDisplay dayView: CalendarDayView, with date: Date)
	func calendarMonthCollectionViewCell(_ cell: CalendarMonthCollectionViewCell, didSelectDayView dayView: CalendarDayView, withDate date: Date)
	func calendarMonthCollectionViewCell(_ cell: CalendarMonthCollectionViewCell, didDeselectDayView dayView: CalendarDayView)
}

class CalendarMonthCollectionViewCell: UICollectionViewCell {

	static let cellIdentifier = "SwiftyMonthCollectionViewCell"

	lazy var monthView: CalendarMonthView = {
		let view = CalendarMonthView()
		view.delegate = self
		return view
	}()
	
	weak var delegate: CalendarMonthCollectionViewCellDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		
		contentView.addSubview(monthView)
		
		monthView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func update(calendarMonth: CalendarMonth) {
		monthView.calendarMonth = calendarMonth
	}
}

extension CalendarMonthCollectionViewCell: CalendarMonthViewDelegate {
	func calendarMonthView(_ monthView: CalendarMonthView, willDisplay dayView: CalendarDayView, with date: Date) {
		delegate?.calendarMonthCollectionViewCell(self, willDisplay: dayView, with: date)
	}
	
	func calendarMonthView(_ monthView: CalendarMonthView, didSelectDayView dayView: CalendarDayView, withDate date: Date) {
		delegate?.calendarMonthCollectionViewCell(self, didSelectDayView: dayView, withDate: date)
	}
	
	func calendarMonthView(_ monthView: CalendarMonthView, didDeselectDayView dayView: CalendarDayView) {
		delegate?.calendarMonthCollectionViewCell(self, didDeselectDayView: dayView)
	}
}

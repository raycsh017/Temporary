import UIKit
import SnapKit

protocol CalendarMonthViewDelegate: class {
	func calendarMonthView(_ monthView: CalendarMonthView, willDisplay dayView: CalendarDayView, with date: Date)
	func calendarMonthView(_ monthView: CalendarMonthView, didSelectDayView dayView: CalendarDayView, withDate date: Date)
	func calendarMonthView(_ monthView: CalendarMonthView, didDeselectDayView dayView: CalendarDayView)
}

class CalendarMonthView: UIView {
	
	fileprivate let numberOfColumns: Int = 7
	fileprivate let numberOfRows: Int = 6
	
	lazy var dayCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.sectionInset = .zero
		layout.minimumInteritemSpacing = 0.0
		layout.minimumLineSpacing = 0.0
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = .white
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(CalendarDayCollectionViewCell.self, forCellWithReuseIdentifier: CalendarDayCollectionViewCell.cellIdentifier)
		return collectionView
	}()
	
	weak var delegate: CalendarMonthViewDelegate?

	var calendarMonth: CalendarMonth? {
		didSet {
			refresh()
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		
		addSubview(dayCollectionView)
		
		dayCollectionView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func refresh() {
		dayCollectionView.reloadData()
	}

}

// MARK: - UICollectionViewDataSource
extension CalendarMonthView: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return calendarMonth?.dates.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let calendarMonth = calendarMonth else {
			return UICollectionViewCell()
		}
		
		guard let dayCell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDayCollectionViewCell.cellIdentifier, for: indexPath) as? CalendarDayCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		let dateCellIndex = indexPath.row
		let date = calendarMonth.dates[dateCellIndex]
		
		switch dateCellIndex {
		case calendarMonth.inDatesIndexRange:
			dayCell.configureText(date.dayString, withColor: .black)
		case calendarMonth.preDatesIndexRange,
		     calendarMonth.postDatesIndexRange:
			dayCell.configureText(date.dayString, withColor: .gray)
		default:
			return UICollectionViewCell()
		}
		
		delegate?.calendarMonthView(self, willDisplay: dayCell.dayView, with: date)

		return dayCell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let calendarMonth = calendarMonth else {
			return
		}
		
		guard let dayCell = collectionView.cellForItem(at: indexPath) as? CalendarDayCollectionViewCell else {
			return
		}
		
		let dayView = dayCell.dayView
		let dayCellIndex = indexPath.row
		let date = calendarMonth.dates[dayCellIndex]
		
		delegate?.calendarMonthView(self, didSelectDayView: dayView, withDate: date)
	}
	
	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		guard let calendarMonth = calendarMonth else {
			return
		}
		
		guard let dayCell = collectionView.cellForItem(at: indexPath) as? CalendarDayCollectionViewCell else {
			return
		}
		
		let dayView = dayCell.dayView
		
		delegate?.calendarMonthView(self, didDeselectDayView: dayView)
	}
	
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CalendarMonthView: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cellWidth = Double(collectionView.bounds.width) / Double(numberOfColumns)
		let cellWidthFloored = CGFloat(floor(cellWidth))

		let cellHeight = Double(collectionView.bounds.height) / Double(numberOfRows)
		let cellHeightFloored = CGFloat(floor(cellHeight))

		return CGSize(width: cellWidthFloored, height: cellHeightFloored)
	}
}

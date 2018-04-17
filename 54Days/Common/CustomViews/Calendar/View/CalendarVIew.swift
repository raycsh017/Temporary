import UIKit
import SnapKit

protocol CalendarViewDelegate: class {
	func calendarView(_ calendar: CalendarView, willDisplay dayView: CalendarDayView, with date: Date)
	func calendarView(_ calendar: CalendarView, didSelectDayView dayView: CalendarDayView, withDate date: Date)
	func calendarView(_ calendar: CalendarView, didDeselectDayView dayView: CalendarDayView)
}

class CalendarView: UIView {
	
	let yearTitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = UIFont.boldSystemFont(ofSize: 20.0)
		label.textAlignment = .left
		return label
	}()
	
	let monthTitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = UIFont.boldSystemFont(ofSize: 28.0)
		label.textAlignment = .left
		return label
	}()
	
	let weekdayTitlesStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.distribution = .fillEqually
		return stackView
	}()
	
	lazy var monthCollectionView: UICollectionView = {
		let flowlayout = UICollectionViewFlowLayout()
		flowlayout.scrollDirection = .horizontal
		flowlayout.sectionInset = .zero
		flowlayout.minimumInteritemSpacing = 0
		flowlayout.minimumLineSpacing = 0

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
		collectionView.backgroundColor = .white
		collectionView.isPagingEnabled = true
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(CalendarMonthCollectionViewCell.self, forCellWithReuseIdentifier: CalendarMonthCollectionViewCell.cellIdentifier)
		return collectionView
	}()

	weak var delegate: CalendarViewDelegate?
	
	lazy var viewModel: CalendarViewModel = {
		let viewModel = CalendarViewModel()
		viewModel.delegate = self
		return viewModel
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(yearTitleLabel)
		addSubview(monthTitleLabel)
		addSubview(weekdayTitlesStackView)
		addSubview(monthCollectionView)
		
		yearTitleLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		monthTitleLabel.snp.makeConstraints { (make) in
			make.top.equalTo(yearTitleLabel.snp.bottom).offset(8.0)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		weekdayTitlesStackView.snp.makeConstraints { (make) in
			make.top.equalTo(monthTitleLabel.snp.bottom).offset(12.0)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}

		monthCollectionView.snp.makeConstraints { (make) in
			make.top.equalTo(weekdayTitlesStackView.snp.bottom).offset(8.0)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		configure()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		
		adjustCalendarOffsetToCenter()
	}
	
	func reloadData() {
		monthCollectionView.reloadData()
	}

	private func configure() {
		configureYearAndMonthTitles()
		configureWeekdayTitles()
	}
	
	private func configureYearAndMonthTitles() {
		let currentYear = viewModel.currentYearTitle
		let currentMonth = viewModel.currentMonthTitle
		
		yearTitleLabel.text = currentYear
		monthTitleLabel.text = currentMonth
	}
	
	private func configureWeekdayTitles() {
		let weekdayTitles = viewModel.weekdayTitles
		
		for title in weekdayTitles {
			let label = UILabel()
			label.textAlignment = .center
			label.textColor = .black
			label.text = title
			
			weekdayTitlesStackView.addArrangedSubview(label)
		}
	}
}

extension CalendarView: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.calendarMonths.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let monthCell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarMonthCollectionViewCell.cellIdentifier, for: indexPath) as? CalendarMonthCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		let monthCellIndex = indexPath.row
		let calendarMonth = viewModel.calendarMonths[monthCellIndex]
		
		monthCell.update(calendarMonth: calendarMonth)
		monthCell.delegate = self
		
		return monthCell
	}
}

extension CalendarView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return monthCollectionView.bounds.size
	}
}

extension CalendarView: UIScrollViewDelegate {
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let pageWidth = scrollView.bounds.width
		let newPageIndex = Int(scrollView.contentOffset.x / pageWidth)

		viewModel.updateMonthsBasedOnNewPage(withIndex: newPageIndex)
	}
}

extension CalendarView: CalendarViewModelDelegate {
	func didUpdateMonths() {
		adjustCalendarOffsetToCenter()
		
		yearTitleLabel.text = viewModel.currentYearTitle
		monthTitleLabel.text = viewModel.currentMonthTitle
		monthCollectionView.reloadData()
	}
	
	func adjustCalendarOffsetToCenter() {
		monthCollectionView.layoutIfNeeded()
		
		let centerMonthStartingOffset = CGPoint(x: monthCollectionView.bounds.width, y: 0.0)
		monthCollectionView.contentOffset = centerMonthStartingOffset
	}
}

extension CalendarView: CalendarMonthCollectionViewCellDelegate {
	func calendarMonthCollectionViewCell(_ cell: CalendarMonthCollectionViewCell, willDisplay dayView: CalendarDayView, with date: Date) {
		delegate?.calendarView(self, willDisplay: dayView, with: date)
	}
	
	func calendarMonthCollectionViewCell(_ cell: CalendarMonthCollectionViewCell, didSelectDayView dayView: CalendarDayView, withDate date: Date) {
		delegate?.calendarView(self, didSelectDayView: dayView, withDate: date)
	}
	
	func calendarMonthCollectionViewCell(_ cell: CalendarMonthCollectionViewCell, didDeselectDayView dayView: CalendarDayView) {
		delegate?.calendarView(self, didDeselectDayView: dayView)
	}
}

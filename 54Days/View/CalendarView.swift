import UIKit
import SnapKit

protocol CalendarViewDelegate: class {
	func calendarView(_ calendar: CalendarView, willDisplay dayView: CalendarDayView, with date: Date)
	func calendarView(_ calendar: CalendarView, didSelectDayView dayView: CalendarDayView, withDate date: Date)
	func calendarView(_ calendar: CalendarView, didDeselectDayView dayView: CalendarDayView)
	func calendarViewDidScrollToAdjacentMonth(_ calendar: CalendarView)
}

class CalendarView: UIView {
	private static let centerPageIndex: Int = 1
	
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
	
	let monthCollectionViewFlowLayout: UICollectionViewFlowLayout = {
		let flowlayout = UICollectionViewFlowLayout()
		flowlayout.scrollDirection = .horizontal
		flowlayout.sectionInset = .zero
		flowlayout.minimumInteritemSpacing = 0
		flowlayout.minimumLineSpacing = 0
		return flowlayout
	}()
	
	lazy var monthCollectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.monthCollectionViewFlowLayout)
		collectionView.backgroundColor = .white
		collectionView.isPagingEnabled = true
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(CalendarMonthCollectionViewCell.self, forCellWithReuseIdentifier: CalendarMonthCollectionViewCell.cellIdentifier)
		return collectionView
	}()

	var pageWidth: CGFloat {
		get {
			return monthCollectionView.bounds.width
		}
	}

	weak var delegate: CalendarViewDelegate?

	let viewModel = CalendarViewModel()

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

		setupWeekdayTitles()
		reloadData()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		centerContent()
	}

	private func setupWeekdayTitles() {
		viewModel.getWeekdayTitles { [weak self] (titles) in
			for title in titles {
				let label = UILabel()
				label.textAlignment = .center
				label.textColor = .black
				label.text = title
				self?.weekdayTitlesStackView.addArrangedSubview(label)
			}
		}
	}

	func reloadData() {
		viewModel.getYearAndMonth { [weak self] (yearTitle, monthTitle) in
			self?.yearTitleLabel.text = yearTitle
			self?.monthTitleLabel.text = monthTitle
		}

		monthCollectionView.reloadData()
		centerContent()
	}
}

// MARK: - CalendarView: UICollectionViewDataSource
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

		guard let calendarMonth = viewModel.calendarMonths.getItem(at: indexPath.row) else {
			return UICollectionViewCell()
		}

		monthCell.update(calendarMonth: calendarMonth)
		monthCell.delegate = self

		return monthCell
	}
}

// MARK: - CalendarView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension CalendarView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return monthCollectionView.bounds.size
	}
}

// MARK: - CalendarView: UIScrollViewDelegate
extension CalendarView: UIScrollViewDelegate {
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let pageIndexAfterScroll = Int(scrollView.contentOffset.x / pageWidth)

		guard pageIndexAfterScroll != CalendarView.centerPageIndex else {
			return
		}

		if pageIndexAfterScroll < CalendarView.centerPageIndex {
			viewModel.shiftCalendarMonthsRight { [weak self] in
				self?.reloadData()
			}
		} else {
			viewModel.shiftCalendarMonthsLeft { [weak self] in
				self?.reloadData()
			}
		}
	}
}

extension CalendarView {
	private func centerContent() {
		monthCollectionView.layoutIfNeeded()
		monthCollectionView.contentOffset = CGPoint(x: pageWidth, y: 0.0)
	}
}

// MARK: - CalendarView: CalendarMonthCollectionViewCellDelegate
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

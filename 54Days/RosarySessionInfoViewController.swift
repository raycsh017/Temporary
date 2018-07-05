import UIKit
import SnapKit

protocol RosarySessionInfoEventHandler: class {
	func didShowRosaryForm()
	func didEditRosaryPetitionSummary(_ petitionSummary: String?)
	func didChangeRosaryStartDate(_ date: Date)
	func didCompleteRosaryForm()
}

class RosarySessionInfoViewController: TableViewController {
	private let tableViewBottomInset: CGFloat = 80.0
	
	let calendarContainerView: UIView = {
		let view = UIView()
		return view
	}()
	
	lazy var calendarView: CalendarView = {
		let calendar = CalendarView(frame: .zero)
		calendar.delegate = self
		return calendar
	}()
	
	lazy var rosaryPeriodSetterOpenButton: UIButton = {
		let button = UIButton(frame: .zero)
		button.layer.cornerRadius = CornerRadius.cr4
		button.backgroundColor = Color.RosaryYellow
		
		button.titleLabel?.font = Font.bf16
		button.setTitle("묵주기도 시작일 설정", for: .normal)
		button.setTitleColor(Color.White, for: .normal)
		
		button.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)
		return button
	}()
	
	lazy var rosaryFormModal: RosaryFormModalView = {
		let modalView = RosaryFormModalView()
		modalView.delegate = self
		return modalView
	}()
	
	weak var eventHandler: RosarySessionInfoEventHandler?
	
	lazy var viewModel: RosarySessionInfoViewModel = {
		let viewModel = RosarySessionInfoViewModel()
		viewModel.userInterface = self
		eventHandler = viewModel
		return viewModel
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		navigationItem.title = "달력"
		tableView.contentInset.bottom = tableViewBottomInset
		
		safeAreaView.addSubview(rosaryPeriodSetterOpenButton)
		
		calendarContainerView.addSubview(calendarView)
		
		calendarView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(Spacing.s16)
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalToSuperview().offset(-Spacing.s16)
			make.height.equalTo(400.0)
		}
		
		rosaryPeriodSetterOpenButton.snp.makeConstraints { (make) in
			make.left.equalToSuperview().offset(Spacing.s16)
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalToSuperview().offset(-Spacing.s16)
			make.height.equalTo(48.0)
		}
		
		tableViewUtility.register(cells: viewModel.cellConfigurators())
		tableViewUtility.reloadData()
		
		setHeaderView(calendarContainerView)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) {
		return
	}
	
	@objc private func tappedButton(_ sender: Any) {
		rosaryFormModal.show()
	}
}

// MARK: - User Interface
extension RosarySessionInfoViewController: RosarySessionInfoUserInterface {
	func refreshWith(cellConfigurators: [CellConfiguratorType]) {
		calendarView.reloadData()
		tableViewUtility.reloadData(withCellConfigurators: cellConfigurators)
	}
	
	func updateRosaryForm(petitionSummary text: String) {
		rosaryFormModal.petitionSummaryTextView.text = text
	}
	
	func updateRosaryForm(startDateText text: String) {
		rosaryFormModal.startDateTextField.text = text
	}
	
	func updateRosaryForm(datePickerDate date: Date) {
		rosaryFormModal.datePicker.setDate(date, animated: false)
	}
}

// MARK: - Other View Delegates
extension RosarySessionInfoViewController: CalendarViewDelegate {
	func calendarViewDidScrollToAdjacentMonth(_ calendar: CalendarView) {
		return
	}
	
	func calendarView(_ calendar: CalendarView, willDisplay dayView: CalendarDayView, with date: Date) {
		if date.isToday {
			dayView.dayLabel.textColor = Color.RosaryYellow
		}
		
		if let rosaryDates = viewModel.rosaryPeriod?.rosaryDates,
		    let dateMatchingRosaryDate = rosaryDates.filter({ $0.date.isOnSameDay(as: date) }).first {
			let primaryMysteryColor = dateMatchingRosaryDate.mystery.assignedColor
			let secondaryMysteryColor = dateMatchingRosaryDate.additionalMystery?.assignedColor
			dayView.showEventIndicators(withColors: [primaryMysteryColor, secondaryMysteryColor])
		} else {
			dayView.hideEventIndicators()
		}
		
		return
	}
	
	func calendarView(_ calendar: CalendarView, didSelectDayView dayView: CalendarDayView, withDate date: Date) {
		// no-op
	}
	
	func calendarView(_ calendar: CalendarView, didDeselectDayView dayView: CalendarDayView) {
		// no-op
	}
}

extension RosarySessionInfoViewController: RosaryFormModalViewDelegate {
	func rosaryFormModalViewDidShow(_ modalView: RosaryFormModalView) {
		eventHandler?.didShowRosaryForm()
	}
	
	func rosaryFormModalViewDidTapConfirm(_ modalView: RosaryFormModalView) {
		eventHandler?.didCompleteRosaryForm()
	}
	
	func rosaryFormModalView(_ modalView: RosaryFormModalView, didEditPetitionSummary petitionSummary: String?) {
		eventHandler?.didEditRosaryPetitionSummary(petitionSummary)
	}
	
	func rosaryFormModalView(_ modalView: RosaryFormModalView, didChangeStartDate startDate: Date) {
		eventHandler?.didChangeRosaryStartDate(startDate)
	}
}

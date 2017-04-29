//
//  CalendarViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/5/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit
import JTAppleCalendar
import RealmSwift

class CalendarViewController: UIViewController{
	
	// MARK: - View Config Variables
	let colorScheme = RosaryColor.scheme
	
	let circleViewWidth: CGFloat = 8.0
	
	// MARK: - Outlets and Custom Views
	@IBOutlet weak var calendarView: UIView!
	@IBOutlet weak var calendarMonthLabel: UILabel!
	@IBOutlet weak var calendarBodyView: JTAppleCalendarView!{
		didSet{
			self.calendarBodyView.dataSource = self
			self.calendarBodyView.delegate = self
			self.calendarBodyView.registerCellViewXib(file: "CalendarDayCellView")
			
			self.calendarBodyView.scrollingMode = .stopAtEachCalendarFrameWidth
		}
	}
	
	@IBOutlet weak var joyfulView: UIView!{
		didSet{
			self.joyfulView.layer.cornerRadius = circleViewWidth / 2
			self.joyfulView.backgroundColor = colorScheme[0].uiColor
		}
	}
	
	@IBOutlet weak var lightView: UIView!{
		didSet{
			self.lightView.layer.cornerRadius = circleViewWidth / 2
			self.lightView.backgroundColor = colorScheme[1].uiColor
		}
	}
	
	@IBOutlet weak var sorrowfulView: UIView!{
		didSet{
			self.sorrowfulView.layer.cornerRadius = circleViewWidth / 2
			self.sorrowfulView.backgroundColor = colorScheme[2].uiColor
		}
	}
	
	@IBOutlet weak var gloriousView: UIView!{
		didSet{
			self.gloriousView.layer.cornerRadius = circleViewWidth / 2
			self.gloriousView.backgroundColor = colorScheme[3].uiColor
		}
	}
	
	@IBOutlet weak var rosaryPeriodView: UIView!
	@IBOutlet weak var startDateBodyLabel: UILabel!
	@IBOutlet weak var endDateBodyLabel: UILabel!
	
	@IBOutlet weak var calendarResetButton: UIButton!
	
	let calendarResetModalView = CalendarResetModalView()
	
	// MARK: - Static Variables
	let calendar = Calendar.current
	let currentDate = Date()
	let dateFormatter = DateFormatter()
	
	let calendarViewModel = CalendarViewModel()
	
	
	
	// MARK: - Overrides and Additional View Setup
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		// Add shadows to views after they have the correct size
		self.calendarView.addShadow()
		self.rosaryPeriodView.addShadow()
		self.calendarResetButton.addShadow()
		
		// Adjust itemSize after calendarBodyView has the correct size
		self.calendarBodyView.itemSize = self.calendarBodyView.bounds.width / 7
	}
	
	func setup(){
		self.automaticallyAdjustsScrollViewInsets = false
		self.calendarBodyView.scrollToDate(self.currentDate)
		self.updateCalendarHeader(dateInMonth: self.currentDate)
		
		// If rosaryPeriod is set, update the start and end date labels
		guard
			let rosaryPeriod = self.calendarViewModel.rosaryPeriod,
			let startDate = rosaryPeriod.startDate,
			let endDate = rosaryPeriod.endDate
		else{
			return
		}
		self.updateDatesLabels(startDate: startDate, endDate: endDate)
		self.setupViews()
		self.setupConstraints()
	}
	
	func setupViews(){
		self.calendarResetModalView.delegate = self
		self.view.addSubview(self.calendarResetModalView)
	}
	
	func setupConstraints(){
		
//		self.calendarResetModalView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//		self.calendarResetModalView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//		self.calendarResetModalView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//		self.calendarResetModalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
	}
	
	// MARK: - View Related Functions
	func updateDatesLabels(startDate: Date, endDate: Date){
		self.dateFormatter.dateFormat = "MM/dd/yyyy"
		self.startDateBodyLabel.text = self.dateFormatter.string(from: startDate)
		self.endDateBodyLabel.text = self.dateFormatter.string(from: endDate)
	}
	
	func updateCalendarHeader(dateInMonth: Date){
		self.dateFormatter.dateFormat = "MMMM yyyy"
		let monthString = self.dateFormatter.string(from: dateInMonth)
		self.calendarMonthLabel.text = monthString
	}
}

// MARK: - CalendarResetModalDelegate
extension CalendarViewController: CalendarResetModalDelegate{
	func resetCalendar(with selectedDate: Date) {
		let startDate = selectedDate
		let endDate = self.calendarViewModel.findEndOfRosaryPeriod(usingStartDate: startDate)
		
		self.calendarViewModel.updateRosaryPeriod(withStartDate: startDate, andEndDate: endDate){
			[weak self] (startDate, endDate) in
			self?.updateDatesLabels(startDate: startDate, endDate: endDate)
			self?.calendarBodyView.reloadData()
		}
	}
}

// MARK: - Presenter
extension CalendarViewController{
	@IBAction func openCalendarResetModal(_ sender: Any) {
		self.calendarResetModalView.animateView()
	}
}

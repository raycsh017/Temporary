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

struct RosaryDate{
	let date: Date
	let colorIndex: Int
}

class CalendarViewController: UIViewController, CalendarResetModalDelegate {

	let colorScheme = RosaryColor.scheme
	
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
	
	let circleViewWidth: CGFloat = 8.0
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
	
	@IBOutlet weak var startDateView: UIView!
	@IBOutlet weak var startDateBodyLabel: UILabel!
	@IBOutlet weak var endDateView: UIView!
	@IBOutlet weak var endDateBodyLabel: UILabel!
	
	@IBOutlet weak var calendarResetButton: UIButton!
	
	
	let currentDate = Date()
	let dateFormatter = DateFormatter()
	let calendar = Calendar.current

	let realm = try! Realm()
	
	var rosaryPeriod: RosaryPeriod?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		self.calendarView.addShadow()
		self.startDateView.addShadow()
		self.endDateView.addShadow()
		self.calendarResetButton.addShadow()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		self.calendarBodyView.itemSize = self.calendarBodyView.bounds.width / 7
	}
	
	func setup(){
		self.calendarBodyView.scrollToDate(self.currentDate)
		self.updateCalendarHeader(dateInMonth: self.currentDate)
		
		// Retrieve data from Realm
		let rosaryPeriods = realm.objects(RosaryPeriod.self)
		self.rosaryPeriod = rosaryPeriods.first
		
		// Check if RosaryPeriod exists in Realm. If not, create an object
		if self.rosaryPeriod == nil{
			self.rosaryPeriod = RosaryPeriod()
			try! self.realm.write {
				self.realm.add(self.rosaryPeriod!)
			}
		}
		else{
			if let startDate = self.rosaryPeriod?.startDate, let endDate = self.rosaryPeriod?.endDate{
				self.updateDatesLabels(startDate: startDate, endDate: endDate)
			}
		}
	}
	
	@IBAction func openCalendarResetModal(_ sender: Any) {
		let calendarResetModalVC = self.storyboard?.instantiateViewController(withIdentifier: "CalendarResetModalViewController") as? CalendarResetModalViewController
		calendarResetModalVC?.modalPresentationStyle = .overCurrentContext
		calendarResetModalVC?.delegate = self
		self.present(calendarResetModalVC!, animated: false, completion: nil)
	}
	
	// CalendarResetModalDelegate function
	func calendarReset(with selectedDate: Date) {
		let startDate = selectedDate
		// We add 53 to the startDate, because the period is start-date-inclusive
		let daysInOnePeriod = 53
		let endDate = self.calendar.date(byAdding: Calendar.Component.day, value: daysInOnePeriod, to: startDate)!
		self.writeDatesToRealm(startDate: startDate, endDate: endDate) { 
			self.updateDatesLabels(startDate: startDate, endDate: endDate)
			self.calendarBodyView.reloadData()
		}
	}
	func writeDatesToRealm(startDate: Date, endDate: Date, completion: ()->()){
		if let rosaryPeriod = self.rosaryPeriod{
			try! self.realm.write{
				rosaryPeriod.startDate = startDate
				rosaryPeriod.endDate = endDate
			}
			completion()
		}
	}
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

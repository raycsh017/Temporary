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

class CalendarViewController: UIViewController, CalendarResetModalDelegate {

	let LIGHT_GRAY = UIColor(colorLiteralRed: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
	let colorScheme = [
		UIColor.withRGB(red: 252, green: 177, blue: 122),
		UIColor.withRGB(red: 239, green: 132, blue: 100),
		UIColor.withRGB(red: 214, green: 73, blue: 90),
		UIColor.withRGB(red: 72, green: 73, blue: 137)
	]
	
	@IBOutlet weak var calendarView: UIView!
	@IBOutlet weak var calendarMonthLabel: UILabel!{
		didSet{
			self.dateFormatter.dateFormat = "yyyy MM"
			let monthString = self.dateFormatter.string(from: self.currentDate)
			self.calendarMonthLabel.text = monthString
		}
	}
	@IBOutlet weak var calendarBodyView: JTAppleCalendarView!{
		didSet{
			self.calendarBodyView.dataSource = self
			self.calendarBodyView.delegate = self
			self.calendarBodyView.registerCellViewXib(file: "CalendarDayCellView")
		}
	}
	
	@IBOutlet weak var startDateView: UIView!
	@IBOutlet weak var startDateBodyLabel: UILabel!
	@IBOutlet weak var endDateView: UIView!
	@IBOutlet weak var endDateBodyLabel: UILabel!
	
	@IBOutlet weak var calendarResetButton: UIButton!{
		didSet{
			self.calendarResetButton.setTitle("", for: .normal)
			self.calendarResetButton.setImage(UIImage(named: "ic_calendar_reset"), for: .normal)
		}
	}
	
	let currentDate = Date()
	let dateFormatter = DateFormatter()

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
	}
	
	func setup(){
		// Retrieve data from Realm
		let rosaryPeriods = realm.objects(RosaryPeriod.self)
		self.rosaryPeriod = rosaryPeriods.first
		
		// Check if RosaryPeriod exists in Realm. If not, create an object
		if self.rosaryPeriod == nil{
			print("1")
			self.rosaryPeriod = RosaryPeriod()
			try! self.realm.write {
				self.realm.add(self.rosaryPeriod!)
			}
		}
		else{
			print("2")
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
		let endDate = Calendar.current.date(byAdding: Calendar.Component.day, value: daysInOnePeriod, to: startDate)!
		self.writeDatesToRealm(startDate: startDate, endDate: endDate)
	}
	
	func writeDatesToRealm(startDate: Date, endDate: Date){
		if let rosaryPeriod = self.rosaryPeriod{
			try! self.realm.write{
				rosaryPeriod.startDate = startDate
				rosaryPeriod.endDate = endDate
			}
			self.updateDatesLabels(startDate: startDate, endDate: endDate)
		}
	}
	func updateDatesLabels(startDate: Date, endDate: Date){
		self.dateFormatter.dateFormat = "MM/dd/yyyy"
		self.startDateBodyLabel.text = self.dateFormatter.string(from: startDate)
		self.endDateBodyLabel.text = self.dateFormatter.string(from: endDate)
	}
	
}

//
//  CalendarViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/5/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit
import JTAppleCalendar
class CalendarViewController: UIViewController {

	let LIGHT_GRAY = UIColor(colorLiteralRed: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
	let colorScheme = [
		UIColor.withRGB(red: 252, green: 177, blue: 122),
		UIColor.withRGB(red: 239, green: 132, blue: 100),
		UIColor.withRGB(red: 214, green: 73, blue: 90),
		UIColor.withRGB(red: 72, green: 73, blue: 137)
	]
	
	@IBOutlet weak var calendarView: UIView!{
		didSet{
			self.calendarView.addShadow()
		}
	}
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
	
	@IBOutlet weak var calendarResetButton: UIButton!{
		didSet{
			self.calendarResetButton.setTitle("", for: .normal)
			self.calendarResetButton.setImage(UIImage(named: "ic_calendar_reset"), for: .normal)
		}
	}
	let currentDate = Date()
	let dateFormatter = DateFormatter()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
	}
	
	func setup(){
//		self.modalPresentationStyle = .overCurrentContext
	}
	@IBAction func openCalendarResetModal(_ sender: Any) {
		let calendarResetModalVC = self.storyboard?.instantiateViewController(withIdentifier: "CalendarResetModalViewController") as? CalendarResetModalViewController
		calendarResetModalVC?.modalPresentationStyle = .overCurrentContext
		self.present(calendarResetModalVC!, animated: false, completion: nil)
	}
}

//
//  CalendarResetModalViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/7/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

protocol CalendarResetModalDelegate{
	func calendarReset(with selectedDate: Date)
}

class CalendarResetModalViewController: UIViewController {

	let buttonFontSize: CGFloat = 15.0
	
	@IBOutlet weak var backgroundView: UIView!{
		didSet{
			self.backgroundView.backgroundColor = .black
			self.backgroundView.alpha = 0.0
		}
	}
	@IBOutlet weak var datePickerModalView: UIView!{
		didSet{
			self.datePickerModalView.layer.cornerRadius = FiftyFour.modalRadius
		}
	}
	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var confirmButton: UIButton!{
		didSet{
			self.confirmButton.backgroundColor = UIColor.withRGB(red: 0, green: 189, blue: 157)
			self.confirmButton.layer.cornerRadius = FiftyFour.buttonRadius
			self.confirmButton.setTitleColor(.white, for: .normal)
			self.confirmButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: self.buttonFontSize)
		}
	}
	@IBOutlet weak var cancelButton: UIButton!{
		didSet{
			self.cancelButton.backgroundColor = UIColor.withRGB(red: 244, green: 95, blue: 99)
			self.cancelButton.layer.cornerRadius = FiftyFour.buttonRadius
			self.cancelButton.setTitleColor(.white, for: .normal)
			self.cancelButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: self.buttonFontSize)
		}
	}
	
	var delegate: CalendarResetModalDelegate?
	var newRosaryStartDate: Date?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.setup()
    }
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.animateView()
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
	}
	
	func setup(){
		self.view.backgroundColor = .clear
	}
	
	func animateView(){
		self.datePickerModalView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
		self.datePickerModalView.alpha = 0.0
		UIView.animate(withDuration: 0.25) {
			self.backgroundView.alpha = 0.4
			self.datePickerModalView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			self.datePickerModalView.alpha = 1.0
		}
	}
	func deAnimateView(){
		UIView.animate(withDuration: 0.25, animations: { 
			self.datePickerModalView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
			self.datePickerModalView.alpha = 0.0
			self.backgroundView.alpha = 0.0
		}) { (completed) in
			if completed{
				self.dismiss(animated: false, completion: nil)
			}
		}
	}
	
	@IBAction func confirmReset(_ sender: Any) {
		self.delegate?.calendarReset(with: datePicker.date)
		self.deAnimateView()
	}
	@IBAction func cancelReset(_ sender: Any) {
		self.deAnimateView()
	}
	
}

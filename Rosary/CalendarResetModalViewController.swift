//
//  CalendarResetModalViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/7/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class CalendarResetModalViewController: UIViewController {

	let radius: CGFloat = 4.0
	let fontSize: CGFloat = 15.0
	
	@IBOutlet weak var backgroundView: UIView!{
		didSet{
			backgroundView.backgroundColor = .black
			backgroundView.alpha = 0.0
		}
	}
	@IBOutlet weak var datePickerWrapperView: UIView!{
		didSet{
			datePickerWrapperView.layer.cornerRadius = radius
		}
	}
	@IBOutlet weak var datePickerView: UIDatePicker!
	@IBOutlet weak var confirmButton: UIButton!{
		didSet{
			confirmButton.backgroundColor = UIColor.withRGB(red: 0, green: 189, blue: 157)
			confirmButton.layer.cornerRadius = radius
			confirmButton.setTitleColor(.white, for: .normal)
			confirmButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: fontSize)
		}
	}
	@IBOutlet weak var cancelButton: UIButton!{
		didSet{
			cancelButton.backgroundColor = UIColor.withRGB(red: 244, green: 95, blue: 99)
			cancelButton.layer.cornerRadius = radius
			cancelButton.setTitleColor(.white, for: .normal)
			cancelButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: fontSize)
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setup()
    }
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		animateView()
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
	}
	
	func setup(){
		self.view.backgroundColor = .clear
	}
	
	func animateView(){
		self.datePickerWrapperView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
		self.datePickerWrapperView.alpha = 0.0
		UIView.animate(withDuration: 0.25) {
			self.backgroundView.alpha = 0.4
			self.datePickerWrapperView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			self.datePickerWrapperView.alpha = 1.0
		}
	}
	func deAnimateView(){
		UIView.animate(withDuration: 0.25, animations: { 
			self.datePickerWrapperView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
			self.datePickerWrapperView.alpha = 0.0
			self.backgroundView.alpha = 0.0
		}) { (completed) in
			if completed{
				self.dismiss(animated: false, completion: nil)
			}
		}
	}
	
	@IBAction func changedDate(_ sender: Any) {
		
	}
	@IBAction func confirmReset(_ sender: Any) {
		
	}
	@IBAction func cancelReset(_ sender: Any) {
		deAnimateView()
	}
}

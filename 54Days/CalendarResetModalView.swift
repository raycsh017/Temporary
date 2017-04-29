//
//  CalendarResetModalView.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/7/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

protocol CalendarResetModalDelegate: class{
	func resetCalendar(with selectedDate: Date)
}

class CalendarResetModalView: UIView{
	
	// MARK: - Custom Views
	let backgroundView: UIView = {
		let view = UIView()
		view.alpha = 0.0
		view.backgroundColor = .black
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let containerView: UIView = {
		let view = UIView()
		view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
		view.layer.cornerRadius = FiftyFour.modalRadius
		view.alpha = 0.0
		view.backgroundColor = .white
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let instructionLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = UIFont.systemFont(ofSize: 15.0)
		
		label.text = "묵주기도 시작 날짜를 정해주세요."
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let datePicker: UIDatePicker = {
		let datePicker = UIDatePicker()
		datePicker.datePickerMode = .date
		
		datePicker.date = Date()
		datePicker.translatesAutoresizingMaskIntoConstraints = false
		return datePicker
	}()
	
	let buttonStackView: UIStackView = {
		let stackview = UIStackView()
		stackview.axis = .horizontal
		stackview.alignment = .center
		stackview.distribution = .fillEqually
		stackview.spacing = 8.0
		stackview.translatesAutoresizingMaskIntoConstraints = false
		return stackview
	}()
	
	let confirmButton: UIButton = {
		let button = UIButton()
		button.layer.cornerRadius = FiftyFour.buttonRadius
		button.backgroundColor = UIColor.withRGB(red: 0, green: 189, blue: 157)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
		
		button.setTitle("시작 날짜로 설정", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	let cancelButton: UIButton = {
		let button = UIButton()
		button.layer.cornerRadius = FiftyFour.buttonRadius
		button.backgroundColor = UIColor.withRGB(red: 244, green: 95, blue: 99)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
		
		button.setTitle("취소", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	// MARK: - Static Variables
	weak var delegate: CalendarResetModalDelegate?
	
	// MARK: - Overrides and Additional View Setups
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.setup()
	}

	func setup(){
		// Setup properties for the parent view
		self.isHidden = true
		self.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
		self.backgroundColor = .clear
		
		self.setupViews()
		self.setupConstraints()
		self.setupActions()
	}
	
	func setupViews(){
		// Setup view hierarchy
		self.containerView.addSubview(self.instructionLabel)
		self.containerView.addSubview(self.datePicker)
		
		self.buttonStackView.addArrangedSubview(self.cancelButton)
		self.buttonStackView.addArrangedSubview(self.confirmButton)
		self.containerView.addSubview(self.buttonStackView)
		
		self.addSubview(self.backgroundView)
		self.addSubview(self.containerView)
	}
	
	func setupConstraints(){
		self.backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		self.backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		self.backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
		self.backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		
		self.containerView.heightAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 12.0/16.0)
		self.containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0).isActive = true
		self.containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0).isActive = true
		self.containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		
		self.instructionLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 16.0).isActive = true
		self.instructionLabel.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
		
		self.datePicker.topAnchor.constraint(equalTo: self.instructionLabel.bottomAnchor, constant: 16.0).isActive = true
		self.datePicker.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 8.0).isActive = true
		self.datePicker.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -8.0).isActive = true
		self.datePicker.bottomAnchor.constraint(equalTo: self.buttonStackView.topAnchor, constant: -16.0).isActive = true
		
		self.buttonStackView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 8.0).isActive = true
		self.buttonStackView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -8.0).isActive = true
		self.buttonStackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -8.0).isActive = true
		
		self.confirmButton.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
		self.cancelButton.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
	}
	
	func setupActions(){
		self.confirmButton.addTarget(self, action: #selector(self.confirmReset(_:)), for: .touchUpInside)
		self.cancelButton.addTarget(self, action: #selector(self.cancelReset(_:)), for: .touchUpInside)
	}
	
	func animateView(){
		self.isHidden = false
		UIView.animate(withDuration: 0.25) {
			self.backgroundView.alpha = 0.5
			self.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			self.containerView.alpha = 1.0
		}
	}
	
	func deAnimateView(){
		UIView.animate(withDuration: 0.25, animations: {
			self.backgroundView.alpha = 0.0
			self.containerView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
			self.containerView.alpha = 0.0
		}) { (completed) in
			self.isHidden = true
		}
	}
	
	func confirmReset(_ sender: Any){
		self.delegate?.resetCalendar(with: self.datePicker.date)
		self.deAnimateView()
	}
	
	func cancelReset(_ sender: Any){
		self.deAnimateView()
	}
}

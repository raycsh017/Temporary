////
////  CreditsModalViewController.swift
////  Rosary
////
////  Created by Sang Hyuk Cho on 2/27/17.
////  Copyright © 2017 sang. All rights reserved.
////
//
//import UIKit
//
//class CreditsModalViewController: UIViewController {
//	
//	@IBOutlet weak var backgroundView: UIView!{
//		didSet{
//			self.backgroundView.backgroundColor = .black
//			self.backgroundView.alpha = 0.0
//		}
//	}
//	@IBOutlet weak var creditsModalView: UIView!{
//		didSet{
//			self.creditsModalView.layer.cornerRadius = FiftyFour.modalRadius
//		}
//	}
//	@IBOutlet weak var confirmButton: UIButton!{
//		didSet{
//			self.confirmButton.layer.cornerRadius = FiftyFour.modalRadius
//		}
//	}
//	
//	override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//		self.setup()
//    }
//	override func viewWillAppear(_ animated: Bool) {
//		super.viewWillAppear(animated)
//		self.animateView()
//	}
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//	
//	override func viewDidLayoutSubviews() {
//		super.viewDidLayoutSubviews()
//		
//		self.confirmButton.addShadow()
//	}
//    
//	func setup(){
//		self.view.backgroundColor = .clear
//	}
//	
//	func animateView(){
//		self.creditsModalView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//		self.creditsModalView.alpha = 0.0
//		UIView.animate(withDuration: 0.25) {
//			self.backgroundView.alpha = 0.6
//			self.creditsModalView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//			self.creditsModalView.alpha = 1.0
//		}
//	}
//	func deAnimateView(){
//		UIView.animate(withDuration: 0.25, animations: {
//			self.creditsModalView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//			self.creditsModalView.alpha = 0.0
//			self.backgroundView.alpha = 0.0
//		}) { (completed) in
//			if completed{
//				self.dismiss(animated: false, completion: nil)
//			}
//		}
//	}
//	
//	@IBAction func dismissModal(_ sender: Any) {
//		self.deAnimateView()
//	}
//}

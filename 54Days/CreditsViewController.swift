////
////  CreditsViewController.swift
////  54Days
////
////  Created by Sang Hyuk Cho on 4/28/17.
////  Copyright © 2017 sang. All rights reserved.
////
//
//import UIKit
//
//class CreditsViewController: UIViewController {
//	
//	// MARK: - Outlets
//	@IBOutlet weak var developmentContributorsLabel: UILabel!
//	@IBOutlet weak var designContributorsLabel: UILabel!
//	@IBOutlet weak var openSourceLibrariesLabel: UILabel!
//	@IBOutlet weak var iconDesignersLabel: UILabel!
//	
//	// MARK: - Static Variables
//	let developers = ["조상혁"]
//	let designers = ["조상혁"]
//	
//	let openSourceLibraries = [
//		"JTAppleCalendar",
//		"SwiftyJSON",
//		"Realm"
//	]
//	
//	let iconDesigners = [
//		"Ruslan Dezign",
//		"Vladimir Matsak",
//		"Oksana Latysheva",
//		"Zlatko Najdenovski",
//		"Darius Dan"
//	]
//	
//	
//	
//	// MARK: - Overrides and Additional View Setups
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//		self.setup()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//		
//        // Dispose of any resources that can be recreated.
//    }
//    
//	func setup(){
//		guard
//			let devContributers = self.developers.prettyFormat(),
//			let designContributers = self.designers.prettyFormat(),
//			let openSourceLibraries = self.openSourceLibraries.prettyFormat(),
//			let iconDesigners = self.iconDesigners.prettyFormat() else{
//				return
//		}
//		
//		self.developmentContributorsLabel.text = devContributers
//		self.designContributorsLabel.text = designContributers
//		self.openSourceLibrariesLabel.text = openSourceLibraries
//		self.iconDesignersLabel.text = iconDesigners
//	}
//}

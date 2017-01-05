//
//  MainViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 12/29/16.
//  Copyright © 2016 sang. All rights reserved.
//

import UIKit
import SwiftyJSON

struct MainTitle{
	let title: String
	let color: UIColor
	let icon: UIImage
}

class MainViewController: UIViewController {
	

	@IBOutlet weak var joyfulView: UIView!{
		didSet{
			
			self.joyfulView.layer.borderWidth = 2
			self.joyfulView.layer.borderColor = UIColor.withRGB(red: 252, green: 177, blue: 122).cgColor
			
		}
	}
	@IBOutlet weak var joyfulImageView: UIImageView!{
		didSet{
			self.joyfulImageView.image = UIImage(named: "Star")
		}
	}
	@IBOutlet weak var lightView: UIView!{
		didSet{
			self.lightView.layer.borderWidth = 2
			self.lightView.layer.borderColor = UIColor.withRGB(red: 239, green: 132, blue: 100).cgColor
		}
	}
	@IBOutlet weak var lightImageView: UIImageView!{
		didSet{
			self.lightImageView.image = UIImage(named: "Fish")
		}
	}
	@IBOutlet weak var sorrowfulView: UIView!{
		didSet{
			self.sorrowfulView.layer.borderWidth = 2
			self.sorrowfulView.layer.borderColor = UIColor.withRGB(red: 214, green: 73, blue: 90).cgColor
		}
	}
	@IBOutlet weak var sorrowfulImageView: UIImageView!{
		didSet{
			self.sorrowfulImageView.image = UIImage(named: "Crown")
		}
	}
	@IBOutlet weak var gloriousView: UIView!{
		didSet{
			self.gloriousView.layer.borderWidth = 2
			self.gloriousView.layer.borderColor = UIColor.withRGB(red: 72, green: 73, blue: 137).cgColor
		}
	}
	@IBOutlet weak var gloriousImageView: UIImageView!{
		didSet{
			self.gloriousImageView.image = UIImage(named: "Cross")
		}
	}
	@IBOutlet weak var mainPrayerView: UIView!{
		didSet{
			self.mainPrayerView.layer.borderWidth = 2
			self.mainPrayerView.layer.borderColor = UIColor.black.cgColor
		}
	}
	
	var rosaryMysteries: [RosaryMystery] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.loadInitialRosaryData()
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func loadInitialRosaryData(){
		// Get static data from a local JSON file (rosaryData.json)
		let path = Bundle.main.path(forResource: "rosaryData", ofType: "json")!
		let data = try! Data(contentsOf: URL(fileURLWithPath: path))
		let json = JSON(data: data)
		
		print(json["startingPrayer"])
//		// Parse JSON and initialize var:rosaryMysteries
//		for (_, mystery) in json{
//			var tmpMystery = RosaryMystery()
//			for(_, mysterySection) in mystery{
//				let tmpMysterySection = RosaryMysterySection(title: mysterySection["title"].string!, subText: mysterySection["subText"].string!, mainText: mysterySection["mainText"].string!, endingText: mysterySection["endingText"].string!)
//				tmpMystery.sections.append(tmpMysterySection)
//			}
//			self.rosaryMysteries.append(tmpMystery)
//		}
	}
	func touchedViews(sender: UIView){
		
	}
	
}


//	let titles: [MainTitle] = [
//		MainTitle(title: "환희의 신비", color: UIColor.withRGB(red: 252, green: 177, blue: 122), icon: UIImage(named: "Star")!),
//		MainTitle(title: "빛의 신비", color: UIColor.withRGB(red: 239, green: 132, blue: 100), icon: UIImage(named: "Fish")!),
//		MainTitle(title: "고통의 신비", color: UIColor.withRGB(red: 214, green: 73, blue: 90), icon: UIImage(named: "Crown")!),
//		MainTitle(title: "영광의 신비", color: UIColor.withRGB(red: 72, green: 73, blue: 137), icon: UIImage(named: "Cross")!)
//	]
//
//	var titleViews: [UIView] = []
//
//	let mainPrayersTitleView: UIView = {
//		let view = UIView()
//		view.layer.borderWidth = 3
//		view.layer.borderColor = UIColor.black.cgColor
//		view.translatesAutoresizingMaskIntoConstraints = false
//		return view
//	}()
//	let mainPrayersTitleLabel: UILabel = {
//		let label = UILabel()
//		label.text = "주요 기도문"
//		label.textColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
//		label.font = UIFont.boldSystemFont(ofSize: 15)
//		label.translatesAutoresizingMaskIntoConstraints = false
//		return label
//	}()
//
//
//	func setupViews(){
//		for i in 0..<4{
//			let titleView = UIView()
//			titleView.translatesAutoresizingMaskIntoConstraints = false
//			titleView.layer.borderWidth = 3
//			titleView.layer.borderColor = self.titles[i].color.cgColor
//			titleView.tag = i
//			// Create an icon for each view and center it
//			let iconImageView = UIImageView(image: self.titles[i].icon)
//			iconImageView.translatesAutoresizingMaskIntoConstraints = false
//			iconImageView.contentMode = .scaleAspectFit
//			titleView.addSubview(iconImageView)
//
//			titleViews.append(titleView)
//			self.view.addSubview(titleView)
//		}
//		self.view.addSubview(self.mainPrayersTitleView)
//		self.mainPrayersTitleView.addSubview(self.mainPrayersTitleLabel)
//	}
//	func setupConstraints(){
//		let margin: CGFloat = 20.0
//		let mainPrayersTitleViewHeight: CGFloat = 45.0
//		let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
//		let titleViewWidth = (UIScreen.main.bounds.width - (margin * 3)) / 2
//		var titleViewHeight = UIScreen.main.bounds.height - navigationBarHeight
//		titleViewHeight = (titleViewHeight - (margin * 5) - mainPrayersTitleViewHeight) / 2
//
//		// Set constraint for mainPrayersTitleView
//		self.mainPrayersTitleView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: margin).isActive = true
//		self.mainPrayersTitleView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -(margin)).isActive = true
//		self.mainPrayersTitleView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(margin)).isActive = true
//		self.mainPrayersTitleView.heightAnchor.constraint(equalToConstant: mainPrayersTitleViewHeight).isActive = true
//
//		// Set constraint for mainPrayersTitleLabel
//		self.mainPrayersTitleLabel.centerXAnchor.constraint(equalTo: self.mainPrayersTitleView.centerXAnchor).isActive = true
//		self.mainPrayersTitleLabel.centerYAnchor.constraint(equalTo: self.mainPrayersTitleView.centerYAnchor).isActive = true
//
//		// Set the constraints for titleViews
//		// Upper left
//		self.titleViews[0].topAnchor.constraint(equalTo: self.view.topAnchor, constant: (margin*2) + navigationBarHeight).isActive = true
//		self.titleViews[0].leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: margin).isActive = true
//		// Upper right
//		self.titleViews[1].topAnchor.constraint(equalTo: self.view.topAnchor, constant: (margin*2) + navigationBarHeight).isActive = true
//		self.titleViews[1].rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -(margin)).isActive = true
//		// Lower left
//		self.titleViews[2].bottomAnchor.constraint(equalTo: self.mainPrayersTitleView.topAnchor, constant: -(margin)).isActive = true
//		self.titleViews[2].leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: margin).isActive = true
//		// Lower right
//		self.titleViews[3].bottomAnchor.constraint(equalTo: self.mainPrayersTitleView.topAnchor, constant: -(margin)).isActive = true
//		self.titleViews[3].rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -(margin)).isActive = true
//
//		// Set constraint for titleViews, common values
//		for i in 0..<4{
//			titleViews[i].widthAnchor.constraint(equalToConstant: titleViewWidth).isActive = true
//			titleViews[i].heightAnchor.constraint(equalToConstant: titleViewHeight).isActive = true
//			titleViews[i].subviews[0].widthAnchor.constraint(equalToConstant: 53).isActive = true
//			titleViews[i].subviews[0].heightAnchor.constraint(equalToConstant: 68).isActive = true
//			titleViews[i].subviews[0].centerXAnchor.constraint(equalTo: (titleViews[i].centerXAnchor)).isActive = true
//			titleViews[i].subviews[0].centerYAnchor.constraint(equalTo: (titleViews[i].centerYAnchor)).isActive = true
//		}
//	}
//
//	func setupActions(){
//		for i in 0..<4{
//			let touchGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(MainViewController.))
//			self.titleViews[i].addGestureRecognizer(<#T##gestureRecognizer: UIGestureRecognizer##UIGestureRecognizer#>)
//			self.titleViews[i].isUserInteractionEnabled = true
//		}
//	}

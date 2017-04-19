//
//  PrayersListViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 12/29/16.
//  Copyright © 2016 sang. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class PrayersListViewController: UIViewController{
	
	// MARK: - View Config Variables
	// MARK: Common Values
	let viewSpacing: CGFloat = 16.0
	
	// MARK: UICollectionView Values
	let numCellsInRow: Int = 4

	let sectionTopMargin: CGFloat = 4.0
	let sectionBottomMargin: CGFloat = 16.0
	
	let cellSpacing: CGFloat = 16.0
	
	// MARK: Identifiers
	let prayersSegueIdentifier = "mainToPrayersSegue"
	
	
	
	// MARK: - Outlets
	@IBOutlet weak var miniCalendarView: UIView!
	@IBOutlet weak var miniCalendarDayLabel: UILabel!{
		didSet{
			self.dateFormatter.dateFormat = "dd"
			self.miniCalendarDayLabel.text = self.dateFormatter.string(from: self.currentDate)
		}
	}
	@IBOutlet weak var miniCalendarMonthLabel: UILabel!{
		didSet{
			self.dateFormatter.dateFormat = "MMM"
			self.miniCalendarMonthLabel.text = self.dateFormatter.string(from: self.currentDate).uppercased()
		}
	}
	@IBOutlet weak var miniCalendarDescriptionLabel: UILabel!
	
	@IBOutlet weak var prayersListContainerView: UIView!{
		didSet{
			self.prayersListContainerView.backgroundColor = FiftyFour.color.lightGray
			self.prayersListContainerView.clipsToBounds = true
		}
	}
	@IBOutlet weak var prayersListCollectionView: UICollectionView!{
		didSet{
			let flowLayout = UICollectionViewFlowLayout()
			flowLayout.minimumLineSpacing = self.cellSpacing
			flowLayout.minimumInteritemSpacing = self.cellSpacing
			flowLayout.sectionInset = UIEdgeInsets(top: self.sectionTopMargin, left: 0, bottom: self.sectionBottomMargin, right: 0)
			self.prayersListCollectionView.setCollectionViewLayout(flowLayout, animated: false)
			
			self.prayersListCollectionView.backgroundColor = FiftyFour.color.lightGray
			self.prayersListCollectionView.clipsToBounds = false
			self.prayersListCollectionView.showsHorizontalScrollIndicator = false
			
			self.prayersListCollectionView.dataSource = self
			self.prayersListCollectionView.delegate = self
			
			self.prayersListCollectionView.register(PrayersListCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: PrayersListCollectionHeaderView.identifier)
		}
	}
	
	// MARK: - Static Variables
	let currentDate = Date()
	let dateFormatter = DateFormatter()
	let prayersListViewModel = PrayersListViewModel()
	
	// MARK: - Dynamic Variables
	var selectedIndexPath: IndexPath?
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
		self.setup()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		// Additional setup after all views have been laid out in right sizes
		self.miniCalendarView.addShadow()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Update miniCalendar if the rosary period has been reset
		self.prayersListViewModel.findMysteryForToday(errorHandler: { 
			self.miniCalendarDescriptionLabel.text = "묵주기도를 안 하고 계시네요 :("
		}) { [weak self](description) in
			self?.miniCalendarDescriptionLabel.attributedText = description
		}
	}
	
	func setup(){
		self.automaticallyAdjustsScrollViewInsets = false
		
		self.prayersListViewModel.setup()
	}
}

// MARK: - UICollectionView DataSource and Delegates
extension PrayersListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
	
	// MARK: UICollectionView Section Config
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return self.prayersListViewModel.prayerTypes.count
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		
		let headerWidth: CGFloat = collectionView.bounds.width
		let headerHeight: CGFloat = 20.0
		
		return CGSize(width: headerWidth, height: headerHeight)
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		// Prepare a reusable view for the UICollectionView header
		switch kind{
		case UICollectionElementKindSectionHeader:
			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PrayersListCollectionHeaderView.identifier, for: indexPath) as? PrayersListCollectionHeaderView
			let sectionTitle = self.prayersListViewModel.prayerTypes[indexPath.section].inKorean
	
			headerView?.setValues(title: sectionTitle)
			
			return headerView!
		default:
			return UICollectionReusableView()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.prayersListViewModel.prayerTypes[section].data.count
	}
	
	// MARK: UICollectionView Cell Config
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let colViewWidth = collectionView.bounds.width
		let cellWidth = (colViewWidth - (self.cellSpacing * CGFloat(self.numCellsInRow - 1))) / CGFloat(self.numCellsInRow)
		
		return CGSize(width: cellWidth, height: cellWidth)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrayersListCollectionViewCell.identifier, for: indexPath) as? PrayersListCollectionViewCell
		let prayerType = self.prayersListViewModel.prayerTypes[indexPath.section]
		
		switch prayerType{
		case .rosary(let rosaryTypes):
			let rosaryType = rosaryTypes[indexPath.row]
			cell?.setValues(title: rosaryType.inKorean, icon: rosaryType.icon)
			cell?.addShadow()
		case .general(let generalTypes):
			let generalType = generalTypes[indexPath.row]
			cell?.setValues(title: generalType.title, icon: generalType.icon)
			cell?.addShadow()
		}
		
		return cell!
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.selectedIndexPath = indexPath
		self.performSegue(withIdentifier: self.prayersSegueIdentifier, sender: self)
	}
}

// MARK: Presenter
extension PrayersListViewController{
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let selectedSection = self.selectedIndexPath?.section,
			let selectedRow = self.selectedIndexPath?.row else{
				return
		}
		
		let destVC = segue.destination as? PrayersViewController
		let prayerType = self.prayersListViewModel.prayerTypes[selectedSection]
		
		switch prayerType{
		case .rosary(let mysteryTypes):
			let mysteryKey = mysteryTypes[selectedRow].inEnglish
			guard let prayer = self.prayersListViewModel.rosaryPrayers[mysteryKey] else{
				return
			}
			destVC?.prayersViewModel.prayer = .rosary(prayer)
		case .general(_):
			let prayer = self.prayersListViewModel.generalPrayers
			destVC?.prayersViewModel.prayer = .general(prayer)
		}
	}
}

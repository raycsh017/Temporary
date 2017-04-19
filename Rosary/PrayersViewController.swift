//
//  PrayersViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/13/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class PrayersViewController: UIViewController {

	// MARK: - View Config Variables
	// MARK: Common Values
	let viewSpacing: CGFloat = 16.0
	
	// MARK: UICollectionView Values
	let sectionTopMargin: CGFloat = 4.0
	let sectionBottomMargin: CGFloat = 24.0
	
	let cellSpacing: CGFloat = 16.0
	
	

	// MARK: - Outlets
	@IBOutlet weak var prayersCollectionView: UICollectionView!{
		didSet{
			let flowLayout = UICollectionViewFlowLayout()
			flowLayout.minimumLineSpacing = self.cellSpacing
			flowLayout.minimumInteritemSpacing = 0
			flowLayout.sectionInset = UIEdgeInsets(top: self.sectionTopMargin, left: 0, bottom: self.sectionBottomMargin, right: 0)
			self.prayersCollectionView.setCollectionViewLayout(flowLayout, animated: false)
			
			self.prayersCollectionView.backgroundColor = FiftyFour.color.lightGray
			self.prayersCollectionView.clipsToBounds = false
			self.prayersCollectionView.showsVerticalScrollIndicator = false
			
			self.prayersCollectionView.dataSource = self
			self.prayersCollectionView.delegate = self
			
			self.prayersCollectionView.register(PrayersCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: PrayersCollectionHeaderView.identifier)
		}
	}
	
	// MARK: - Static variables
	let prayersViewModel = PrayersViewModel()
	
	// MARK: - Dynamic variables
	var selectedCellIndexPath: IndexPath?
	
	// MARK: - Overrides
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
		self.automaticallyAdjustsScrollViewInsets = false
	}
}


// MARK: - UICollectionView DataSource and Delegates
extension PrayersViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
	
	// MARK: UICollectionView Section Config
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		guard let prayer = self.prayersViewModel.prayer else{
			return 0
		}
		
		return prayer.numItemsPerSection.count
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		
		guard let prayer = self.prayersViewModel.prayer else{
			return .zero
		}
		
		guard prayer.hasSectionHeaders else{
			return .zero
		}
		
		let headerWidth: CGFloat = collectionView.bounds.width
		let headerHeight: CGFloat = 20.0
		
		return CGSize(width: headerWidth, height: headerHeight)
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		guard let prayer = self.prayersViewModel.prayer else{
			return UICollectionReusableView()
		}
		
		guard kind == UICollectionElementKindSectionHeader else{
			return UICollectionReusableView()
		}
		
		// Prepare a reusable view for the UICollectionView header
		let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PrayersCollectionHeaderView.identifier, for: indexPath) as? PrayersCollectionHeaderView
		let sectionTitle = prayer.sectionTitles[indexPath.section]
		
		headerView?.setValues(title: sectionTitle)
		
		return headerView!
	}
	
	// MARK: UICollectionView Cell (Section Items) Config
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let prayer = self.prayersViewModel.prayer else{
			return 0
		}
		
		return prayer.numItemsPerSection[section]
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		guard let prayer = self.prayersViewModel.prayer else{
			return .zero
		}
		
		// Variables used to calculate sizes of each CollectionView Cell
		let cellWidth: CGFloat = collectionView.bounds.width
		let cellPadding: CGFloat = 16.0
		let cellContentWidth: CGFloat = cellWidth - (cellPadding * 2)
		
		var cellHeight: CGFloat = 0
		let fixedLabelHeight: CGFloat = 17.0
		let labelsLineSpacing: CGFloat = 8.0
		
		let cellFont = UIFont.systemFont(ofSize: 14.0)
		
		switch prayer{
		case .rosary(let rosaryPrayer):
			switch indexPath.section{
			// Figure out the height for startingPrayerCell
			case 0:
				cellHeight += (cellPadding * 2) + (fixedLabelHeight * 6) + (labelsLineSpacing * 6)
				cellHeight += (rosaryPrayer.startingPrayer.grace as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				cellHeight += (rosaryPrayer.startingPrayer.petition as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				return CGSize(width: cellWidth, height: cellHeight)
			// Figure out the height for mainPrayerCell
			case 1:
				cellHeight += (cellPadding * 2) + (fixedLabelHeight * 3) + (labelsLineSpacing * 4)
				let index = indexPath.row
				let prayer = rosaryPrayer.mystery.sections[index]
				cellHeight += (prayer.title as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				cellHeight += (prayer.subText as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				cellHeight += (prayer.mainText as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				cellHeight += (prayer.endingText as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				return CGSize(width: cellWidth, height: cellHeight)
			// Figure out the height for endingPrayerCell
			case 2:
				cellHeight += (cellPadding * 2) + (fixedLabelHeight * 6) + (labelsLineSpacing * 10)
				cellHeight += (rosaryPrayer.endingPrayer.spirit as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				cellHeight += (rosaryPrayer.endingPrayer.grace as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				cellHeight += (rosaryPrayer.endingPrayer.petition as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				cellHeight += fixedLabelHeight * 14
				cellHeight += (rosaryPrayer.endingPrayer.praise2 as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				return CGSize(width: cellWidth, height: cellHeight)
			default:
				return .zero
			}
		// Figure out the height for generalPrayerCell
		case .general(let generalPrayers):
			let prayer = generalPrayers[indexPath.row]
			cellHeight += (cellPadding * 2) + (labelsLineSpacing * 2) + fixedLabelHeight
			cellHeight += (prayer.text.string as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
			return CGSize(width: cellWidth, height: cellHeight)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let prayer = self.prayersViewModel.prayer else{
			return UICollectionViewCell()
		}
		
		switch prayer{
		case .rosary(let rosaryPrayer):
			switch indexPath.section{
			// Starting Cell
			case 0:
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartingPrayerCollectionViewCell.identifier, for: indexPath) as? StartingPrayerCollectionViewCell
				let prayer = rosaryPrayer.startingPrayer
				cell?.setValues(petitionPrayer: prayer.petition, gracePrayer: prayer.grace)
				cell?.addShadow()
				return cell!
			case 1:
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPrayerCollectionViewCell.identifier, for: indexPath) as? MainPrayerCollectionViewCell
				let index = indexPath.row
				let prayer = rosaryPrayer.mystery.sections[index]
				cell?.setValues(title: prayer.title, subText: prayer.subText, mainText: prayer.mainText, endingText: prayer.endingText)
				cell?.addShadow()
				return cell!
			case 2:
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EndingPrayerCollectionViewCell.identifier, for: indexPath) as? EndingPrayerCollectionViewCell
				let prayer = rosaryPrayer.endingPrayer
				cell?.setValues(spiritPrayer: prayer.spirit, petitionPrayer: prayer.petition, gracePrayer: prayer.grace, praise1Prayer: prayer.praise1, praise2Prayer: prayer.praise2)
				cell?.addShadow()
				return cell!
			default:
				return UICollectionViewCell()
			}
		case .general(let generalPrayers):
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralPrayerCollectionViewCell.identifier, for: indexPath) as? GeneralPrayerCollectionViewCell
			let prayer = generalPrayers[indexPath.row]
			cell?.setValues(title: prayer.title, attributedText: prayer.text)
			cell?.addShadow()
			return cell!
		}
	}
}

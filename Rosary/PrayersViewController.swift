//
//  PrayersViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/13/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class PrayersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	// Common variables used by views
	let startingPrayerCellIdentifier = "startingPrayerCell"
	let mainPrayerCellIdentifier = "mainPrayerCell"
	let endingPrayerCellIdentifier = "endingPrayerCell"
	let commonPrayerCellIdentifier = "commonPrayerCell"
	
	let LIGHT_GRAY = UIColor(colorLiteralRed: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
	
	let screenWidth: CGFloat = UIScreen.main.bounds.width
	let cellLineSpacing: CGFloat = 20.0

	@IBOutlet weak var prayersCollectionView: UICollectionView!{
		didSet{
			let flowLayout = UICollectionViewFlowLayout()
			flowLayout.minimumLineSpacing = self.cellLineSpacing
			flowLayout.minimumInteritemSpacing = 0
			
			self.prayersCollectionView.setCollectionViewLayout(flowLayout, animated: false)
			self.prayersCollectionView.backgroundColor = self.LIGHT_GRAY
			self.prayersCollectionView.clipsToBounds = false
			self.prayersCollectionView.showsVerticalScrollIndicator = false
			
			self.prayersCollectionView.dataSource = self
			self.prayersCollectionView.delegate = self
		}
	}
	
	// Data variables
	var rosaryPrayers: RosaryMystery?
	var commonPrayers: [CommonPrayer]?
	
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
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if self.rosaryPrayers != nil{
			return 7
		}
		if let numPrayers = self.commonPrayers?.count{
			return numPrayers
		}
		return 0
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let cellWidth: CGFloat = collectionView.bounds.width
		let cellPadding: CGFloat = 16.0
		let cellContentWidth: CGFloat = cellWidth - (cellPadding * 2)
		
		var cellHeight: CGFloat = 0
		let fixedLabelHeight: CGFloat = 17.0
		let labelLineSpacing: CGFloat = 8.0
		
		let cellFont = UIFont.systemFont(ofSize: 14.0)
		
		if let rosary = self.rosaryPrayers{
			
			switch indexPath.row{
			case 0:
				cellHeight += (cellPadding * 2) + (fixedLabelHeight * 6) + (labelLineSpacing * 6)
				cellHeight += (rosary.startingPrayer.grace as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				cellHeight += (rosary.startingPrayer.petition as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				return CGSize(width: cellWidth, height: cellHeight)
			case 1...5:
				cellHeight += (cellPadding * 2) + (fixedLabelHeight * 3) + (labelLineSpacing * 4)
				let index = indexPath.row - 1
				let prayer = rosary.sections[index]
				cellHeight += (prayer.title as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				cellHeight += (prayer.subText as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				cellHeight += (prayer.mainText as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				cellHeight += (prayer.endingText as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				return CGSize(width: cellWidth, height: cellHeight)
			case 6:
				cellHeight += (cellPadding * 2) + (fixedLabelHeight * 6) + (labelLineSpacing * 10)
				cellHeight += (rosary.endingPrayer.spirit as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				cellHeight += (rosary.endingPrayer.grace as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				cellHeight += (rosary.endingPrayer.petition as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				cellHeight += fixedLabelHeight * 14
				cellHeight += (rosary.endingPrayer.praise2 as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
				return CGSize(width: cellWidth, height: cellHeight)
			default:
				break
			}
		}
		if let commonPrayers = self.commonPrayers{
			let prayer = commonPrayers[indexPath.row]
			cellHeight += (cellPadding * 2) + (labelLineSpacing * 2) + fixedLabelHeight
			cellHeight += (prayer.text.string as NSString).getEstimatedHeight(with: cellContentWidth, font: cellFont)
			return CGSize(width: cellWidth, height: cellHeight)
		}
		return .zero
		
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let rosary = self.rosaryPrayers{
			switch indexPath.row{
			case 0:
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.startingPrayerCellIdentifier, for: indexPath) as? StartingPrayerCollectionViewCell
				let prayer = rosary.startingPrayer
				cell?.setValues(petitionPrayer: prayer.petition, gracePrayer: prayer.grace)
				cell?.addShadow()
				return cell!
			case 1...5:
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.mainPrayerCellIdentifier, for: indexPath) as? MainPrayerCollectionViewCell
				let index = indexPath.row - 1
				let prayer = rosary.sections[index]
				cell?.setValues(title: prayer.title, subText: prayer.subText, mainText: prayer.mainText, endingText: prayer.endingText)
				cell?.addShadow()
				return cell!
			case 6:
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.endingPrayerCellIdentifier, for: indexPath) as? EndingPrayerCollectionViewCell
				let prayer = rosary.endingPrayer
				cell?.setValues(spiritPrayer: prayer.spirit, petitionPrayer: prayer.petition, gracePrayer: prayer.grace, praise1Prayer: prayer.praise1, praise2Prayer: prayer.praise2)
				cell?.addShadow()
				return cell!
			default:
				break
			}
		}
		if let commonPrayers = self.commonPrayers{
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.commonPrayerCellIdentifier, for: indexPath) as? CommonPrayerCollectionViewCell
			let prayer = commonPrayers[indexPath.row]
			cell?.setValues(title: prayer.title, attributedText: prayer.text)
			cell?.addShadow()
			return cell!
		}
		return UICollectionViewCell()
	}
}

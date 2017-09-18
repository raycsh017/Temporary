////
////  CalendarViewModel.swift
////  54Days
////
////  Created by Sang Hyuk Cho on 4/27/17.
////  Copyright © 2017 sang. All rights reserved.
////
//
//import Foundation
//import RealmSwift
//
//class CalendarViewModel{
//	// MARK: - Static Variables
//	let calendar = Calendar.current
//	
//	let realm = try! Realm()
//	
//	// MARK: - Dynamic Variables
//	var rosaryPeriod: RosaryPeriod?{
//		get{
//			return self.realm.objects(RosaryPeriod.self).first
//		}
//	}
//	
//	// MARK: - Functions
//	func findEndOfRosaryPeriod(usingStartDate startDate: Date) -> Date{
//		// Add 53 to the startDate, because the period is start-date-inclusive
//		let daysInOnePeriod = 53
//		let endDate = self.calendar.date(byAdding: Calendar.Component.day, value: daysInOnePeriod, to: startDate)
//		return endDate!
//	}
//	
//	func updateRosaryPeriod(withStartDate startDate: Date, andEndDate endDate: Date, completionHandler: (Date, Date)->()){
//		//
//		if rosaryPeriod == nil{
//			print("initRosaryPeriod")
//			let rosaryPeriod = RosaryPeriod()
//			try! self.realm.write {
//				self.realm.add(rosaryPeriod)
//			}
//		}
//		
//		guard let rosaryPeriod = self.rosaryPeriod else{
//			return
//		}
//		
//		try! self.realm.write {
//			rosaryPeriod.startDate = startDate
//			rosaryPeriod.endDate = endDate
//		}
//		
//		completionHandler(startDate, endDate)
//	}
//}

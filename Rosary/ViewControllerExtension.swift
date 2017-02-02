//
//  ViewControllerExtension.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/1/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar

extension MainViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
	func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy MM dd"
		
		let startDate = formatter.date(from: "2017 02 01")! // You can use date generated from a formatter
		let endDate = Date()                                // You can also use dates created from this function
		let parameters = ConfigurationParameters(startDate: startDate,
		                                         endDate: endDate,
		                                         numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
												 calendar: Calendar.current,
												 generateInDates: .forAllMonths,
												 generateOutDates: .tillEndOfGrid,
												 firstDayOfWeek: .monday)
		return parameters
	}
	func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
		let myCustomCell = cell as! CalendarDayCellView
		
		// Setup Cell text
		myCustomCell.dayLabel.text = cellState.text
		
		// Setup text color
		if cellState.dateBelongsTo == .thisMonth {
			myCustomCell.dayLabel.textColor = UIColor.black
		} else {
			myCustomCell.dayLabel.textColor = UIColor.gray
		}
	}
}

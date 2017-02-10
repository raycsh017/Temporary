//
//  CalendarViewControllerExtension.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/1/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar

extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
	
	func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
		dateFormatter.dateFormat = "yyyy MM dd"
		
		let startDate = Date()
		let endDate = Date()
		
		let parameters = ConfigurationParameters(startDate: startDate,
		                                         endDate: endDate,
		                                         numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
												 calendar: Calendar.current,
												 generateInDates: .forAllMonths,
												 generateOutDates: .tillEndOfRow,
												 firstDayOfWeek: .sunday)
		return parameters
	}
	func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
		let cellView = cell as! CalendarDayCellView
		
		// Setup text
		cellView.dayLabel.text = cellState.text
		
		self.handleCellTextColor(view: cellView, cellState: cellState)
		self.handleDatesInPeriod(view: cellView, cellState: cellState)
//		self.handleCellSelection(view: cellView, cellState: cellState)
	}
	
	// When cell gets selected (Uni-selection)
	func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
		let cellView = cell as! CalendarDayCellView
//		self.handleCellSelection(view: cellView, cellState: cellState)
		self.handleCellTextColor(view: cellView, cellState: cellState)
	}
	// When cell gets de-selected
	func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
		let cellView = cell as! CalendarDayCellView
//		self.handleCellSelection(view: cellView, cellState: cellState)
		self.handleCellTextColor(view: cellView, cellState: cellState)
	}
	// Function to handle the text color of the calendar
	func handleCellTextColor(view: JTAppleDayCellView?, cellState: CellState) {
		
		guard let cellView = view as? CalendarDayCellView  else {
			return
		}
		
		if cellState.dateBelongsTo == .thisMonth {
			cellView.dayLabel.textColor = .black
		} else {
			cellView.dayLabel.textColor = .gray
		}
	}
	// Function to handle the calendar selection
	func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
		guard let cellView = view as? CalendarDayCellView  else {
			return
		}
		
		dateFormatter.dateFormat = "yyyy MM dd"
		let currentDateString = dateFormatter.string(from: self.currentDate)
		let cellDateString = dateFormatter.string(from: cellState.date)
		
		if cellState.isSelected || currentDateString == cellDateString{
			cellView.daySelectedView.layer.cornerRadius =  2
			cellView.daySelectedView.backgroundColor = UIColor.black
			cellView.daySelectedView.isHidden = false
		} else {
			cellView.daySelectedView.isHidden = true
		}
	}
	func handleDatesInPeriod(view: JTAppleDayCellView?, cellState: CellState){
		guard let cellView = view as? CalendarDayCellView else{
			return
		}
		
		if cellState.dateBelongsTo == .thisMonth{
			if let rosaryStartDate = self.rosaryPeriod?.startDate{
				let date1 = Calendar.current.startOfDay(for: rosaryStartDate)
				let date2 = Calendar.current.startOfDay(for: cellState.date)
				let numDaysBetween = Calendar.current.dateComponents([.day], from: date1, to: date2).day!
				
				switch numDaysBetween{
				case 0..<54:
					let colorIndex = (numDaysBetween < 27) ? (numDaysBetween % 4) : ((numDaysBetween+1) % 4)
					cellView.daySelectedView.layer.cornerRadius = 2
					cellView.daySelectedView.backgroundColor = self.colorScheme[colorIndex]
					cellView.daySelectedView.isHidden = false
				default:
					cellView.daySelectedView.isHidden = true
				}
			}
		}
		else{
			cellView.daySelectedView.isHidden = true
		}
	}
}

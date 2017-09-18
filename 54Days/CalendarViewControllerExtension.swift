////
////  CalendarViewControllerExtension.swift
////  Rosary
////
////  Created by Sang Hyuk Cho on 2/1/17.
////  Copyright © 2017 sang. All rights reserved.
////
//
//import Foundation
//import UIKit
//import JTAppleCalendar
//
//extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
//	
//	func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
//		dateFormatter.dateFormat = "yyyy MM dd"
//		
//		let startDate = self.calendar.date(byAdding: .month, value: -2, to: self.currentDate)!
//		let endDate = self.calendar.date(byAdding: .month, value: 2, to: self.currentDate)!
//		
//		let parameters = ConfigurationParameters(startDate: startDate,
//		                                         endDate: endDate,
//		                                         numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
//												 calendar: self.calendar,
//												 generateInDates: .forAllMonths,
//												 generateOutDates: .tillEndOfRow,
//												 firstDayOfWeek: .sunday)
//		
//		return parameters
//	}
//	
//	func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
//		let cellView = cell as! CalendarDayCellView
//		
//		// Setup text
//		cellView.dayLabel.text = cellState.text
//		
//		self.handleCellTextColor(view: cellView, cellState: cellState)
//		self.handleDatesInPeriod(view: cellView, cellState: cellState)
//		self.handleCellSelection(view: cellView, cellState: cellState)
//	}
//	
//	// When cell gets selected (Uni-selection)
//	func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
//		let cellView = cell as! CalendarDayCellView
//		self.handleCellSelection(view: cellView, cellState: cellState)
//		self.handleCellTextColor(view: cellView, cellState: cellState)
//	}
//	
//	// When cell gets de-selected
//	func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
//		// If deselect happens in the section outside of the visible section, cell == nil
//		if let cellView = cell as? CalendarDayCellView{
//			self.handleCellSelection(view: cellView, cellState: cellState)
//			self.handleCellTextColor(view: cellView, cellState: cellState)
//		}
//	}
//	
//	func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
//		let visibleDate = visibleDates.monthDates.first!
//		self.updateCalendarHeader(dateInMonth: visibleDate)
//	}
//	
//	// Function to handle the text color of the calendar
//	func handleCellTextColor(view: JTAppleDayCellView?, cellState: CellState) {
//		guard let cellView = view as? CalendarDayCellView  else {
//			return
//		}
//		
//		if cellState.dateBelongsTo == .thisMonth {
//			cellView.dayLabel.textColor = .black
//		} else {
//			cellView.dayLabel.textColor = .gray
//		}
//	}
//	
//	// Function to handle the calendar selection
//	func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
//		guard let cellView = view as? CalendarDayCellView  else {
//			return
//		}
//		
//		dateFormatter.dateFormat = "yyyy MM dd"
//		let currentDateString = dateFormatter.string(from: self.currentDate)
//		let cellDateString = dateFormatter.string(from: cellState.date)
//		
//		if cellState.isSelected || currentDateString == cellDateString{
//			cellView.dayContainerView.layer.borderWidth = 1
//			cellView.dayContainerView.layer.borderColor = UIColor.black.cgColor
//		} else {
//			cellView.dayContainerView.layer.borderColor = UIColor.clear.cgColor
//		}
//	}
//	
//	// Function to handle colors for dates in user-set Rosary Period
//	func handleDatesInPeriod(view: JTAppleDayCellView?, cellState: CellState){
//		guard let cellView = view as? CalendarDayCellView else{
//			return
//		}
//		
//		if cellState.dateBelongsTo == .thisMonth{
//			guard let rosaryStartDate = self.calendarViewModel.rosaryPeriod?.startDate else{
//				return
//			}
//			// Check if each day in month belongs to Rosary Period
//			let date1 = self.calendar.startOfDay(for: rosaryStartDate)
//			let date2 = self.calendar.startOfDay(for: cellState.date)
//			let numDaysBetween = self.calendar.dateComponents([.day], from: date1, to: date2).day!
//			
//			switch numDaysBetween{
//			case 0..<54:
//				// If a part of the Rosary period, display a circle view
//				let colorIndex = (numDaysBetween < 27) ? (numDaysBetween % 4) : ((numDaysBetween+1) % 4)
//				cellView.daySelectedView.layer.cornerRadius = 2
//				cellView.daySelectedView.backgroundColor = self.colorScheme[colorIndex].uiColor
//				cellView.daySelectedView.isHidden = false
//				
//				// For 27th and 54th days, display an additional circle view
//				if numDaysBetween == 26 || numDaysBetween == 53{
//					cellView.additionalDaySelectedView.layer.cornerRadius = 2
//					cellView.additionalDaySelectedView.backgroundColor = RosaryColor.darkSlateBlue.uiColor
//					cellView.additionalDaySelectedView.isHidden = false
//				}
//				else{
//					cellView.additionalDaySelectedView.isHidden = true
//				}
//			default:
//				// If not a part of the Rosary period, hide the circle views
//				cellView.daySelectedView.isHidden = true
//				cellView.additionalDaySelectedView.isHidden = true
//			}
//		}
//		else{
//			// If Rosary period is not set, hide the circle views entirely
//			cellView.daySelectedView.isHidden = true
//			cellView.additionalDaySelectedView.isHidden = true
//		}
//	}
//}

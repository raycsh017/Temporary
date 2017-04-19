//
//  CalendarDayCellView.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 1/28/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation
import JTAppleCalendar

class CalendarDayCellView: JTAppleDayCellView{
	@IBOutlet weak var dayContainerView: UIView!
	@IBOutlet weak var dayLabel: UILabel!
	@IBOutlet weak var daySelectedView: UIView!
	@IBOutlet weak var additionalDaySelectedView: UIView!
	@IBOutlet weak var daySelectedStackView: UIStackView!
}

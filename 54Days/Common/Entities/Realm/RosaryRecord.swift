//
//  RosaryPeriodRecord.swift
//  54Days
//
//  Created by Sang Hyuk Cho on 1/13/18.
//  Copyright © 2018 sang. All rights reserved.
//

import Foundation
import RealmSwift

class RosaryRecord: Object {
	@objc dynamic var startDate: Date = Date()
	@objc dynamic var petitionSummary: String = ""
}

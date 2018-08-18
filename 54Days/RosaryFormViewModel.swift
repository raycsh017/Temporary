//
//  RosaryFormViewModel.swift
//  54Days
//
//  Created by Sang Hyuk Cho on 7/12/18.
//  Copyright © 2018 sang. All rights reserved.
//

import Foundation

class RosaryFormViewModel {
	private let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM/dd/yyyy"
		return formatter
	}()

	private(set) var rosaryPetitionText: String = ""
	private(set) var rosaryStartDate: Date = Date()

	var rosaryStartDateText: String {
		return dateFormatter.string(from: rosaryStartDate)
	}

	var rosaryEndDateText: String {
		if let endDate = RosaryDateCalculator.rosaryEndDate(fromStartDate: rosaryStartDate) {
			return dateFormatter.string(from: endDate)
		} else {
			return "-"
		}
	}
}

extension RosaryFormViewModel {
	func cellConfigurators() -> [CellConfiguratorType] {
		var cellConfigurators: [CellConfiguratorType] = []
		cellConfigurators.append(contentsOf: petitionFieldCellConfigurators())
		cellConfigurators.append(contentsOf: dateFieldCellConfigurators())
		return cellConfigurators
	}

	private func petitionFieldCellConfigurators() -> [CellConfiguratorType] {
		let cellData = RosaryFormPetitionFieldCellData(inputText: rosaryPetitionText)
		let cellConfigurator = TableCellConfigurator<RosaryFormPetitionFieldTableViewCell>(cellData: cellData) as CellConfiguratorType
		return [cellConfigurator]
	}

	private func dateFieldCellConfigurators() -> [CellConfiguratorType] {
		let cellData = RosaryFormDateFieldCellData(rosaryStartDate: rosaryStartDate, startDateText: rosaryStartDateText, endDateText: rosaryEndDateText)
		let cellConfigurator = TableCellConfigurator<RosaryFormDateFieldTableViewCell>(cellData: cellData)
		return [cellConfigurator]
	}
}

extension RosaryFormViewModel {
	func setRosaryPetitionText(_ text: String) {
		rosaryPetitionText = text
	}

	func setRosaryStartDate(_ date: Date) {
		rosaryStartDate = date
	}

}

extension RosaryFormViewModel {
	func saveForm(_ completion: (() -> Void)? = nil) {
		RealmDataManager.shared.removeAll()
		RealmDataManager.shared.setObject(ofType: RosaryRecord.self, modify: { (rosaryRecord) in
			rosaryRecord.startDate = rosaryStartDate
			rosaryRecord.petitionSummary = rosaryPetitionText
			rosaryRecord.didComplete = false
		}, completion: completion)
	}
	
}

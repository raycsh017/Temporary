import Foundation

class RosaryFormViewModel {
	private let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM/dd/yyyy"
		return formatter
	}()

	private let initialRosaryPetitionText: String
	private let initialRosaryStartDate: Date

	private(set) var rosaryPetitionText: String
	private(set) var rosaryStartDate: Date

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

	var formDidChange: Bool {
		return (rosaryPetitionText != initialRosaryPetitionText) || (!initialRosaryStartDate.isOnSameDay(as: rosaryStartDate))
	}

	init() {
		if let recentRosaryRecord = RealmDataManager.shared.getFirstObject(ofType: RosaryRecord.self) {
			rosaryPetitionText = recentRosaryRecord.petitionSummary
			rosaryStartDate = recentRosaryRecord.startDate
		} else {
			rosaryPetitionText = ""
			rosaryStartDate = Date().startOfDay
		}
		initialRosaryPetitionText = rosaryPetitionText
		initialRosaryStartDate = rosaryStartDate
	}

	func setRosaryPetitionText(_ text: String) {
		rosaryPetitionText = text
	}

	func setRosaryStartDate(_ date: Date) {
		rosaryStartDate = date
	}	
}

// MARK: - CellConfigurators
extension RosaryFormViewModel {
	func getCellConfigurators(completion: @escaping(([CellConfiguratorType]) -> Void)) {
		var cellConfigurators: [CellConfiguratorType] = []
		cellConfigurators.append(contentsOf: petitionFieldCellConfigurators())
		cellConfigurators.append(contentsOf: dateFieldCellConfigurators())
		completion(cellConfigurators)
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

// MARK: - Realm
extension RosaryFormViewModel {
	func saveForm(_ completion: (() -> Void)? = nil) {
		RealmDataManager.shared.removeAll()
		RealmDataManager.shared.setObject(ofType: RosaryRecord.self, modify: { (rosaryRecord) in
			rosaryRecord.startDate = rosaryStartDate
			rosaryRecord.petitionSummary = rosaryPetitionText
		}, completion: completion)
	}

}

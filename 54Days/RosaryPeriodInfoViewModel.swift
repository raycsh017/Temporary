import Foundation

class RosaryPeriodInfoViewModel {
	private let dateFormatter = DateFormatter()

	private var recentRosaryRecord: RosaryRecord? {
		return RealmDataManager.shared.getFirstObject(ofType: RosaryRecord.self)
	}
}

extension RosaryPeriodInfoViewModel {
	func getPetitionDescriptionViewData(completion: @escaping ((RosaryPeriodInfoPetitionDescriptionViewData) -> Void)) {
		// If haven't set rosary
		guard let recentRosaryRecord = recentRosaryRecord else {
			let viewData = RosaryPeriodInfoPetitionDescriptionViewData(petitionDescriptionHeader: "진행중인 묵주기도가 없습니다", petitionDescription: nil, startDateText: nil, endDateText: nil)
			completion(viewData)
			return
		}

		dateFormatter.dateFormat = "MM/dd/yyyy"

		let petitionDescriptionHeader: String?
		let petitionDescription: String?
		if !recentRosaryRecord.petitionSummary.isEmpty {
			petitionDescriptionHeader = "기도합니다,"
			petitionDescription = recentRosaryRecord.petitionSummary
		} else {
			petitionDescriptionHeader = "작성하신 청원 내용이 없습니다"
			petitionDescription = nil
		}

		let startDate = recentRosaryRecord.startDate
		let startDateText = "시작일: \(dateFormatter.string(from: startDate))"

		let endDateText: String?
		if let endDate = RosaryDateCalculator.rosaryEndDate(fromStartDate: startDate) {
			endDateText = "마지막일: \(dateFormatter.string(from: endDate))"
		} else {
			endDateText = nil
		}

		// If finished rosary
		guard let daysPassedSinceStart = startDate.daysAway(from: Date()),
			  daysPassedSinceStart < RosaryConstants.numberOfDaysInPeriod else {
			let viewData = RosaryPeriodInfoPetitionDescriptionViewData(petitionDescriptionHeader: "진행중인 묵주기도가 없습니다", petitionDescription: nil, startDateText: nil, endDateText: nil)
			completion(viewData)
			return
		}

		let viewData = RosaryPeriodInfoPetitionDescriptionViewData(petitionDescriptionHeader: petitionDescriptionHeader, petitionDescription: petitionDescription, startDateText: startDateText, endDateText: endDateText)
		completion(viewData)
	}

}

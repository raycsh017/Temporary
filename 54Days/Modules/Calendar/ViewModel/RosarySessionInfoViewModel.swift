import Foundation
import Realm
import RealmSwift

protocol RosarySessionInfoUserInterface: class {
	func refreshCalendar()
	func updateRosaryForm(petitionSummary text: String)
	func updateRosaryForm(startDateText text: String)
	func updateRosaryForm(datePickerDate date: Date)
}

class RosarySessionInfoViewModel {
	
	private let dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/dd/yyyy"
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .none
		return dateFormatter
	}()
	
	fileprivate var realm: Realm?
	
	private(set) var formPetitionSummary: String = ""
	private(set) var formStartDate: Date = Date()
	
	private var formStartDateFormatted: String {
		return dateFormatter.string(from: formStartDate)
	}
	
	var rosaryPeriod: RosaryPeriod?
	var recentRosaryRecord: RosaryRecord? {
		return realm?.objects(RosaryRecord.self).first ?? nil
	}
	
	weak var userInterface: RosarySessionInfoUserInterface?
	
	init() {
		initializeRealm()
		loadRecentRosaryRecord()
	}
	
	private func initializeRealm() {
		do {
			realm = try Realm()
		} catch let error as NSError {
			print(error)
		}
	}
	
	private func loadRecentRosaryRecord() {
		reloadRosaryPeriod()
	}
	
	// TEMP
	func deleteAllRecords() {
		do {
			try realm?.write {
				realm?.deleteAll()
				print("Deleting all records in Realm succeeded")
			}
		} catch {
			print("Deleting all records in Realm failed")
		}
	}
}

extension RosarySessionInfoViewModel {
	typealias RosaryDate = RosaryPeriod.RosaryDate
	
	func saveRosaryFormData() {
		guard let realm = realm else {
			return
		}
		
		if let rosaryRecord = recentRosaryRecord {
			do {
				try realm.write {
					rosaryRecord.petitionSummary = formPetitionSummary
					rosaryRecord.startDate = formStartDate
				}
				print("Modification success")
			} catch {
				print("Modification failed")
			}
		} else {
			let rosaryRecord = RosaryRecord()
			rosaryRecord.petitionSummary = formPetitionSummary
			rosaryRecord.startDate = formStartDate
			
			do {
				try realm.write {
					realm.add(rosaryRecord)
					print("Addition Success")
				}
			} catch {
				print("Addition failed")
			}
		}
	}
	
	func reloadRosaryPeriod() {
		guard let startDate = recentRosaryRecord?.startDate else {
			return
		}
		
		let calendar = Calendar.current
		let numberOfDaysInPeriod = RosaryConstants.numberOfDaysInPeriod
		let petitionPeriodLastIndex = RosaryConstants.petitionPeriod.last!
		let startOfStartDate = calendar.startOfDay(for: startDate)
		
		var rosaryDates: [RosaryDate] = []
		for i in 0..<numberOfDaysInPeriod {
			let date = calendar.date(byAdding: .day, value: i, to: startOfStartDate) ?? Date()
			let mysteryIndex = (i <= petitionPeriodLastIndex) ? (i % 4) : ((i + 1) % 4)
			let mystery = RosaryMystery.MysteryType.all[mysteryIndex]
			
			rosaryDates.append(RosaryDate(index: i, date: date, mystery: mystery))
		}
		rosaryPeriod = RosaryPeriod(rosaryDates: rosaryDates)
	}
}

extension RosarySessionInfoViewModel: RosarySessionInfoEventHandler {
	func didShowRosaryForm() {
		resetRosaryFormData()
		userInterface?.updateRosaryForm(petitionSummary: formPetitionSummary)
		userInterface?.updateRosaryForm(startDateText: formStartDateFormatted)
		userInterface?.updateRosaryForm(datePickerDate: formStartDate)
	}
	
	func didEditRosaryPetitionSummary(_ petitionSummary: String?) {
		formPetitionSummary = petitionSummary ?? ""
	}
	
	func didChangeRosaryStartDate(_ date: Date) {
		formStartDate = date
		userInterface?.updateRosaryForm(startDateText: formStartDateFormatted)
	}
	
	func didCompleteRosaryForm() {
		saveRosaryFormData()
		reloadRosaryPeriod()
		userInterface?.refreshCalendar()
	}
}

extension RosarySessionInfoViewModel {
	fileprivate func resetRosaryFormData() {
		formPetitionSummary = ""
		formStartDate = Date()
	}
}

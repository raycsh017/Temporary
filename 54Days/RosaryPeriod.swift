import Foundation

struct RosaryPeriod {
	struct RosaryDate {
		let index: Int
		let date: Date
		let mystery: RosaryMystery.MysteryType
		let additionalMystery: RosaryMystery.MysteryType?
	}
	
	let rosaryDates: [RosaryDate]
}

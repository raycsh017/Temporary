import Foundation

struct RosaryPrayer {
	var mystery: RosaryMystery
	let startingPrayer: RosaryStartingPrayer
	let endingPrayer: RosaryEndingPrayer
}

struct RosaryMystery {
	let type: RosaryMysteryType
	let sections: [Section]
	
	struct Section {
		let title: String
		let subText: String
		let mainText: String
		let endingText: String
	}
}

struct RosaryStartingPrayer {
	let petition: String
	let grace: String
}

struct RosaryEndingPrayer {
	let spirit: String
	let petition: String
	let grace: String
	let praise1: [String]
	let praise2: String
}

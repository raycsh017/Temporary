import Foundation

struct OtherPrayer {
	let title: String
	let textLines: [String]
	let underlineLineOffset: Int?
	
	init(title: String, textLines: [String], underlineLineOffset: Int?) {
		self.title = title
		self.textLines = textLines
		self.underlineLineOffset = underlineLineOffset
	}
}

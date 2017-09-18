import Foundation

struct OtherPrayer {
	let title: String
	let text: NSMutableAttributedString
	let numberOfLines: Int
	
	init(title: String, text: NSMutableAttributedString, numberOfLines: Int) {
		self.title = title
		self.text = text
		self.numberOfLines = numberOfLines
	}
}

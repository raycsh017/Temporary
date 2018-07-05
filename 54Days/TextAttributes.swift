import UIKit

struct TextAttributes {
	let lineSpacing: CGFloat
	let paragraphSpacing: CGFloat
}

extension TextAttributes {
	struct LineSpacing {
		static let `default`: CGFloat = 2.0
	}
	
	struct ParagraphSpacing {
		static let `default`: CGFloat = 8.0
	}
	
	struct Predefined {
		static let Paragraph: TextAttributes = TextAttributes(
			lineSpacing: 2.0,
			paragraphSpacing: 8.0
		)
		static let TextLines: TextAttributes = TextAttributes(
			lineSpacing: 2.0,
			paragraphSpacing: 0.0
		)
	}
}

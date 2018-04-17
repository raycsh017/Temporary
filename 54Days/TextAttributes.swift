import UIKit

struct TextAttributes {
	let lineSpacing: CGFloat
}

extension TextAttributes {
	struct LineSpacing {
		static let `default`: CGFloat = 4.0
	}
}

struct PredefinedTextAttributes {
	static let Paragraph: TextAttributes = TextAttributes(lineSpacing: TextAttributes.LineSpacing.default)
}

import Foundation
import UIKit

struct Color {
	// Light to Dark
	static let White = UIColor.withHex(0xFFFFFF)
	static let BackgroundGray = UIColor.withHex(0xF3F3F3)
	static let Platinum = UIColor.withHex(0xE3E3E3)
	static let SilverSandGray = UIColor.withHex(0xC3C3C3)
	static let StarDust = UIColor.withHex(0x9E9E9E)
	static let BalticSeaGray = UIColor.withHex(0x3E3E3E)
	static let Black = UIColor.withHex(0x3E3E3E)
	static let Clear = UIColor.clear
	
	static let RosaryYellow = UIColor.withHex(0xFFCE54)
	static let RosaryGreen = UIColor.withHex(0xA0D468)
	static let RosaryRed = UIColor.withHex(0xED5565)
	static let RosaryPurple = UIColor.withHex(0xAC92EC)
	
	static let OceanBlue = UIColor.withHex(0x004085)
	static let CrimsonRed = UIColor.withHex(0xBA002F)
	static let Aquamarine = UIColor.withHex(0x71E7A8)
}

extension Color {
	struct Text {
		static let Header = Color.StarDust
		static let Body = Color.Black
	}
	
	struct Form {
		static let Header = Color.StarDust
		static let TextFieldText = Color.Black
		static let TextFieldPlaceholder = Color.Platinum
	}
	
	struct Border {
		static let TextField = Color.Platinum
	}
	
	struct Divider {
		static let Default = Color.BackgroundGray
	}
	
	struct Button {
		static let Confirm = Color.Aquamarine
		static let Cancel = Color.SilverSandGray
	}
	
	struct ToolBar {
		static let Dark = Color.Black
	}
}

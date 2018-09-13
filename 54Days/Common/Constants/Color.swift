import Foundation
import UIKit

struct Color {
	static let Clear = UIColor.clear

	// Light to Dark
	static let White = UIColor.withHex(0xFFFFFF)
	static let BackgroundGray = UIColor.withHex(0xF3F3F3)
	static let Platinum = UIColor.withHex(0xE3E3E3)
	static let SilverSandGray = UIColor.withHex(0xC3C3C3)
	static let StarDust = UIColor.withHex(0x9E9E9E)
	static let BalticSeaGray = UIColor.withHex(0x3E3E3E)
	static let Black = UIColor.withHex(0x3E3E3E)

	//Red
	static let CrimsonRed = UIColor.withHex(0xBA002F)
	static let CoralRed = UIColor.withHex(0xF74042)

	// Green
	static let OceanGreen = UIColor.withHex(0x39A47C)

	// Blue
	static let OceanBlue = UIColor.withHex(0x004085)
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
		static let Confirm = Color.OceanGreen
		static let Neutral = Color.SilverSandGray
		static let Edit = Color.CoralRed
		
		struct State {
			static let Highlighted = Color.Platinum
		}
	}
	
	struct ToolBar {
		static let Dark = Color.Black
	}
	
	struct Rosary {
		static let Yellow = UIColor.withHex(0xFFCE54)
		static let Green = UIColor.withHex(0xA0D468)
		static let Red = UIColor.withHex(0xED5565)
		static let Purple = UIColor.withHex(0xAC92EC)
	}
}

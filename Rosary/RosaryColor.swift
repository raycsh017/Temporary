//
//  RosaryColor.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 3/11/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation
import UIKit

enum RosaryColor: Int{
	case tacao
	case burntSienna
	case darkTerraCotta
	case darkSlateBlue
	
	var uiColor: UIColor{
		switch self{
		case .tacao:
			return UIColor.withRGB(red: 252, green: 177, blue: 122)
		case .burntSienna:
			return UIColor.withRGB(red: 239, green: 132, blue: 100)
		case .darkTerraCotta:
			return UIColor.withRGB(red: 214, green: 73, blue: 90)
		case .darkSlateBlue:
			return UIColor.withRGB(red: 72, green: 73, blue: 137)
		}
	}
	static var scheme: [RosaryColor]{
		return [.tacao, .burntSienna, .darkTerraCotta, .darkSlateBlue]
	}
}

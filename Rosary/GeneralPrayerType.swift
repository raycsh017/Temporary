//
//  GeneralPrayer.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 2/6/17.
//  Copyright © 2017 sang. All rights reserved.
//

import Foundation
import UIKit

// Prayer types other than Rosary
enum GeneralPrayerType: Int{
	case mainPrayer
	
	var title: String{
		switch self{
		case .mainPrayer:
			return "주요 기도문"
		}
	}
	
	var icon: UIImage{
		switch self{
		case .mainPrayer:
			return UIImage(named: "ic_pray")!
		}
	}
	
	static let all: [GeneralPrayerType] = [.mainPrayer]
}

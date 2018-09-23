import Foundation
import UIKit

struct Font {
	static let f12 = UIFont(name: "NanumBarunGothic", size: 12.0)
		?? UIFont.systemFont(ofSize: 12.0)
	static let f14 = UIFont(name: "NanumBarunGothic", size: 14.0)
		?? UIFont.systemFont(ofSize: 14.0)
	static let f16 = UIFont(name: "NanumBarunGothic", size: 16.0)
		?? UIFont.systemFont(ofSize: 16.0)
	
	static let bf14 = UIFont(name: "NanumBarunGothicBold", size: 14.0)
		?? UIFont.boldSystemFont(ofSize: 14.0)
	static let bf16 = UIFont(name: "NanumBarunGothicBold", size: 16.0)
		?? UIFont.boldSystemFont(ofSize: 16.0)
	static let bf20 = UIFont(name: "NanumBarunGothicBold", size: 20.0)
		?? UIFont.boldSystemFont(ofSize: 20.0)
	static let bf24 = UIFont(name: "NanumBarunGothicBold", size: 24.0)
		?? UIFont.boldSystemFont(ofSize: 24.0)
}

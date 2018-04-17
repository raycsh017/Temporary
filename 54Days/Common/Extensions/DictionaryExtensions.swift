import Foundation

extension Dictionary {
	mutating func combined(with dict: Dictionary<Key, Value>) -> Dictionary {
		dict.forEach { (k, v) in
			updateValue(v, forKey: k)
		}
		return self
	}
}

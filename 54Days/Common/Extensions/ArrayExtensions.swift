import Foundation

extension Array {
	func interleave(element: Array.Element) -> Array {
		var interleavedArray: [Array.Element] = []
		// 0 ... N - 2
		for i in 0..<count {
			if i != (count - 1) {
				interleavedArray.append(self[i])
				interleavedArray.append(element)
			}
		}
		
		// N - 1, last element
		if let lastElement = self.last {
			interleavedArray.append(lastElement)
		}
		
		return interleavedArray
	}

	func getItem(at index: Int) -> Element? {
		return index < count ? self[index] : nil
	}
}

import Foundation

class FileUtility {
	init() {
	}
	
	class func loadData(fromJSONFileWithName resourceName: String) -> Data? {
		guard let path = Bundle.main.path(forResource: resourceName, ofType: "json") else {
			return nil
		}
		let data = try? Data(contentsOf: URL(fileURLWithPath: path))
		return data
	}
}

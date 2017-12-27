import Realm
import RealmSwift

class RealmManager {
	static let shared = RealmManager()
	
	private let realm = try? Realm()
	
	var rosaryPeriods: Results<RosaryPeriod>? {
		guard let realm = realm else {
			return nil
		}
		return realm.objects(RosaryPeriod.self)
	}
}

class RosaryPeriod: Object{
	@objc dynamic var startDate: Date?
	@objc dynamic var endDate: Date?
}

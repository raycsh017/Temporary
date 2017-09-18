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
	dynamic var startDate: Date?
	dynamic var endDate: Date?
}

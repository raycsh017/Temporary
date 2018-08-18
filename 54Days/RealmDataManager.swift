//
//  RealmDataManager.swift
//  54Days
//
//  Created by Sang Hyuk Cho on 7/15/18.
//  Copyright © 2018 sang. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmDataManager {
	static let shared = RealmDataManager()
	
	var realm: Realm?
	
	init() {
		do {
			realm = try Realm(configuration: .defaultConfiguration)
		} catch let error {
			print(error)
		}
	}
}

extension RealmDataManager {
	func getFirstObject<T: Object>(ofType type: T.Type) -> T? {
		return realm?.objects(type).first ?? nil
	}

	func setObject<T: Object>(ofType type: T.Type, modify: ((T) -> Void), completion: (() -> Void)? = nil) {
		guard let realm = realm else {
			return
		}

		if let object = realm.objects(type).first {
			do {
				try realm.write {
					modify(object)
				}
			} catch {
				print("Error occurred while writing to existing object")
			}
		} else {
			let object = T()
			modify(object)
			do {
				try realm.write {
					realm.add(object)
				}
			} catch {
				print("Error occurred while writing to add a new object")
			}
		}

		completion?()
	}

	func removeAll(_ completion: (() -> Void)? = nil) {
		guard let realm = realm else {
			return
		}

		do {
			try realm.write {
				realm.deleteAll()
				print("Deleted all records")
			}
		} catch {
			print("Failed to deleteall records")
		}
	}
}

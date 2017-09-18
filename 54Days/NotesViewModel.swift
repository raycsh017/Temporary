////
////  NotesViewModel.swift
////  Rosary
////
////  Created by Sang Hyuk Cho on 4/20/17.
////  Copyright © 2017 sang. All rights reserved.
////
//
//import Foundation
//import RealmSwift
//
//class NotesViewModel{
//	
//	// MARK: - Static Variables
//	let realm = try! Realm()
//	
//	// MARK: - Dynamic Variables
//	var prayerNotes: Results<PrayerNote>{
//		get{
//			return self.realm.objects(PrayerNote.self).sorted(byKeyPath: "addedDate")
//		}
//	}
//	
//	// MARK: - Functions
//	func deleteNote(withRowIndex index: Int, completionHandler: ()->()){
//		let note = self.prayerNotes[index]
//		try! self.realm.write {
//			self.realm.delete(note)
//		}
//		completionHandler()
//	}
//	
//}

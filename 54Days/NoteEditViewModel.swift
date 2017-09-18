////
////  NoteEditViewModel.swift
////  Rosary
////
////  Created by Sang Hyuk Cho on 4/20/17.
////  Copyright © 2017 sang. All rights reserved.
////
//
//import Foundation
//import UIKit
//import RealmSwift
//
//class NoteEditViewModel{
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
//	var noteBeingEdited: PrayerNote?
//	
//	// MARK: - Functions
//	func loadNote(withIndexPath indexPath: IndexPath?, completionHandler: (String)->()){
//		// Load the note with the given indexPath
//		guard let row = indexPath?.row else{
//			return
//		}
//		
//		self.noteBeingEdited = self.prayerNotes[row]
//		completionHandler(self.noteBeingEdited!.content)
//	}
//	
//	func updateCurrentNote(withText text: String){
//		// Create a new note and add it to the realm if necessary
//		if self.noteBeingEdited == nil{
//			self.noteBeingEdited = PrayerNote()
//			try! self.realm.write {
//				self.realm.add(self.noteBeingEdited!)
//			}
//		}
//		
//		// Update the current note with the new text
//		try! self.realm.write {
//			self.noteBeingEdited?.content = text
//		}
//	}
//	
//	func removeCurrentNote(){
//		// Remove the current note if it exists
//		guard let note = self.noteBeingEdited else{
//			return
//		}
//		
//		try! self.realm.write {
//			self.realm.delete(note)
//		}
//	}
//}

//
//  NoteEditViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 3/18/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit
import RealmSwift

protocol NoteEditDelegate: class{
	func noteWasEdited()
}

class NoteEditViewController: UIViewController{

	// MARK: - Outlets and Views
	@IBOutlet weak var noteTextView: UITextView!{
		didSet{
			self.noteTextView.font = UIFont(name: "HelveticaNeue", size: 17.0)
			self.noteTextView.delegate = self
		}
	}
	var doneBarButton = UIBarButtonItem()
	
	// MARK: - Variables passed from previous VC
	var noteToEditIndexPath: IndexPath?
	
	// MARK: - Static variables
	let realm = try! Realm()
	var prayerNotes: Results<PrayerNote>{
		get{
			return self.realm.objects(PrayerNote.self)
		}
	}
	
	// MARK: - Dynamic variables
	var noteBeingEdited: PrayerNote?
	weak var delegate: NoteEditDelegate?
	
	// MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func setup(){
		self.automaticallyAdjustsScrollViewInsets = false
		self.doneBarButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(self.doneEditing))
		
		// Load existing note from Realm if indexPath exists
		if let selectedNoteIndex = self.noteToEditIndexPath?.row{
			self.noteBeingEdited = self.prayerNotes[selectedNoteIndex]
			self.noteTextView.text = self.noteBeingEdited?.content
		}
		else{
			self.navigationItem.rightBarButtonItem = self.doneBarButton
			self.noteTextView.becomeFirstResponder()
		}
	}
	
	func doneEditing(){
		self.noteTextView.endEditing(true)
	}
	func writeCurrentTextToRealm(){
		if !self.noteTextView.text.isEmpty{
			// If we are making a new note, create an object & add it to realm
			if self.noteBeingEdited == nil{
				self.noteBeingEdited = PrayerNote()
				try! self.realm.write{
					self.realm.add(self.noteBeingEdited!)
				}
			}
			// Write whatever is in textview to realm
			try! self.realm.write{
				self.noteBeingEdited?.content = self.noteTextView.text
			}
		}
		else{
			// If current note is a new note and textview is empty do nothing
			// If current note is an existing note and textview is empty, remove it from realm
			if self.noteBeingEdited != nil{
				try! self.realm.write{
					self.realm.delete(self.noteBeingEdited!)
				}
			}
		}
		// Reload tableview in NotesViewController after update
		self.delegate?.noteWasEdited()
	}
}

// MARK: - UITextViewDelegate
extension NoteEditViewController: UITextViewDelegate{
	func textViewDidBeginEditing(_ textView: UITextView) {
		self.navigationItem.rightBarButtonItem = self.doneBarButton
	}
	func textViewDidEndEditing(_ textView: UITextView) {
		self.navigationItem.rightBarButtonItem = nil
		
		self.writeCurrentTextToRealm()
	}
}

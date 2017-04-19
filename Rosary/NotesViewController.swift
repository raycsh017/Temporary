//
//  NotesViewController.swift
//  Rosary
//
//  Created by Sang Hyuk Cho on 3/18/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit
import RealmSwift

class NotesViewController: UIViewController{

	// MARK: - Variables related to views
	let prayerNoteCellIdentifier = "prayerNoteCell"
	
	let noteEditSegueIdentifier = "notesToNoteEditSegue"
	
	// MARK: - Outlets
	@IBOutlet weak var prayerNotesTableView: UITableView!{
		didSet{
			self.prayerNotesTableView.dataSource = self
			self.prayerNotesTableView.delegate = self
		}
	}
	
	// MARK: - Static variables
	let currentDate = Date()
	let dateFormatter = DateFormatter()
	let calendar = Calendar.current
	
	let realm = try! Realm()
	
	// MARK: - Dynamic variables
	var prayerNotes: Results<PrayerNote>{
		get{
			return self.realm.objects(PrayerNote.self)
		}
	}
	
	var noteToEditIndexPath: IndexPath?
	
	// MARK: - Overriding view related functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.setup()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func setup(){
		self.dateFormatter.dateFormat = "MM/dd/yyyy"
		
		let addNoteBarButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(self.addNewNote))
		addNoteBarButton.tintColor = .black
		self.navigationItem.rightBarButtonItem = addNoteBarButton
	}

	func addNewNote(){
		self.noteToEditIndexPath = nil
		self.performSegue(withIdentifier: self.noteEditSegueIdentifier, sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destVC = segue.destination as? NoteEditViewController
		destVC?.noteToEditIndexPath = self.noteToEditIndexPath
		destVC?.delegate = self
	}
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension NotesViewController: UITableViewDataSource, UITableViewDelegate{
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.prayerNotes.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.prayerNoteCellIdentifier)
		let note = self.prayerNotes[indexPath.row]
		
		cell?.textLabel?.text = note.content
		cell?.detailTextLabel?.text = self.dateFormatter.string(from: note.addedDate)
		
		return cell!
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		// Remove the selected note from Realm DB and the prayerNotes Array
		if editingStyle == .delete{
			print("delete item")
			let note = self.prayerNotes[indexPath.row]
			try! self.realm.write {
				self.realm.delete(note)
			}
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.noteToEditIndexPath = indexPath
		self.performSegue(withIdentifier: self.noteEditSegueIdentifier, sender: self)
	}
}

// MARK: - NoteEditDelegate
extension NotesViewController: NoteEditDelegate{
	func noteWasEdited() {
		self.prayerNotesTableView.reloadData()
	}
}

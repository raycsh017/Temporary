////
////  NotesViewController.swift
////  Rosary
////
////  Created by Sang Hyuk Cho on 3/18/17.
////  Copyright © 2017 sang. All rights reserved.
////
//
//import UIKit
//import RealmSwift
//
//class NotesViewController: UIViewController{
//
//	// MARK: - View Config Variables
//	// MARK: Identifiers
//	let prayerNoteCellIdentifier = "prayerNoteCell"
//	
//	let noteEditSegueIdentifier = "notesToNoteEditSegue"
//	
//	// MARK: - Outlets
//	@IBOutlet weak var prayerNotesTableView: UITableView!{
//		didSet{
//			self.prayerNotesTableView.dataSource = self
//			self.prayerNotesTableView.delegate = self
//		}
//	}
//
//	// MARK: - Static variables
//	let currentDate = Date()
//	let dateFormatter = DateFormatter()
//	let calendar = Calendar.current
//	
//	let notesViewModel = NotesViewModel()
//
//	// MARK: - Dynamic variables
//	var noteToEditIndexPath: IndexPath?
//	
//	// MARK: - Overrides and Additional View Setup
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//		self.setup()
//    }
//	
//	override func viewWillAppear(_ animated: Bool) {
//		super.viewWillAppear(animated)
//	}
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//	
//	func setup(){
//		// Date format used by the individual notes
//		self.dateFormatter.dateFormat = "MM/dd/yyyy"
//		
//		// Create a "Add New Note" button on the top right
//		let addNoteBarButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(self.addNewNote))
//		addNoteBarButton.tintColor = .black
//		self.navigationItem.rightBarButtonItem = addNoteBarButton
//	}
//
//	func addNewNote(){
//		// This function doesn't create a new note. Instead, it 
//		// "delegates" creating a new note to NotesEditViewController
//		self.noteToEditIndexPath = nil
//		self.performSegue(withIdentifier: self.noteEditSegueIdentifier, sender: self)
//	}
//}
//
//// MARK: - UITableViewDataSource and Delegate
//extension NotesViewController: UITableViewDataSource, UITableViewDelegate{
//	func numberOfSections(in tableView: UITableView) -> Int {
//		return 1
//	}
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return self.notesViewModel.prayerNotes.count
//	}
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let cell = tableView.dequeueReusableCell(withIdentifier: self.prayerNoteCellIdentifier)
//		let note = self.notesViewModel.prayerNotes[indexPath.row]
//		let title = note.content
//		let date = self.dateFormatter.string(from: note.addedDate)
//		
//		cell?.setValues(mainText: title, detailText: date)
//		
//		return cell!
//	}
//	
//	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//		return true
//	}
//	
//	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//		// Remove the selected note from Realm DB and the prayerNotes Array
//		if editingStyle == .delete{
//			self.notesViewModel.deleteNote(withRowIndex: indexPath.row, completionHandler: {
//				tableView.deleteRows(at: [indexPath], with: .automatic)
//			})
//		}
//	}
//	
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		// Save the indexPath of the note to be edited, send it to the next VC
//		self.noteToEditIndexPath = indexPath
//		self.performSegue(withIdentifier: self.noteEditSegueIdentifier, sender: self)
//	}
//}
//
//// MARK: - Presenter
//extension NotesViewController{
//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		let destVC = segue.destination as? NoteEditViewController
//		destVC?.noteToEditIndexPath = self.noteToEditIndexPath
//		destVC?.delegate = self
//	}
//}
//
//// MARK: - NoteEditDelegate
//extension NotesViewController: NoteEditDelegate{
//	func noteContentDidChanged() {
//		self.prayerNotesTableView.reloadData()
//	}
//}

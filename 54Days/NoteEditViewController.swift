////
////  NoteEditViewController.swift
////  Rosary
////
////  Created by Sang Hyuk Cho on 3/18/17.
////  Copyright © 2017 sang. All rights reserved.
////
//
//import UIKit
//import RealmSwift
//
//protocol NoteEditDelegate: class{
//	func noteContentDidChanged()
//}
//
//class NoteEditViewController: UIViewController{
//
//	// MARK: - Outlets and Custom Views
//	@IBOutlet weak var noteTextView: UITextView!{
//		didSet{
//			self.noteTextView.font = UIFont(name: "HelveticaNeue", size: 17.0)
//			self.noteTextView.showsVerticalScrollIndicator = false
//			self.noteTextView.delegate = self
//		}
//	}
//	var doneBarButton = UIBarButtonItem()
//	
//	
//	
//	// MARK: - Static variables
//	let noteEditViewModel = NoteEditViewModel()
//	
//	// MARK: - Dynamic variables
//	weak var delegate: NoteEditDelegate?
//	
//	var noteToEditIndexPath: IndexPath?
//	
//	
//	
//	// MARK: - Overrides and Additional View Setup
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//		self.setup()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//	
//	func setup(){
//		self.automaticallyAdjustsScrollViewInsets = false
//		self.doneBarButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(self.finishEditing))
//		
//		// Load the existing note from Realm if the indexPath exists
//		// Otherwise, wait for the user input to create a new note
//		self.noteEditViewModel.loadNote(withIndexPath: self.noteToEditIndexPath) { [weak self](loadedText) in
//			self?.noteTextView.text = loadedText
//		}
//		
//		self.registerKeyboardNotifications()
//	}
//	
//	func registerKeyboardNotifications(){
//		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//	}
//	
//	func finishEditing(){
//		self.noteTextView.endEditing(true)
//	}
//	
//	func writeCurrentTextToRealm(){
//		// If the note is empty, remove the note
//		// Otherwise, update it
//		if self.noteTextView.text.isEmpty{
//			self.noteEditViewModel.removeCurrentNote()
//		}
//		else{
//			self.noteEditViewModel.updateCurrentNote(withText: self.noteTextView.text)
//		}
//		
//		// Reload the tableview in NotesViewController after the update
//		self.delegate?.noteContentDidChanged()
//	}
//	
//	func keyboardWillAppear(notification: Notification){
//		let info = notification.userInfo!
//		let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
//		let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
//		
//		self.noteTextView.contentInset = contentInsets
//		self.noteTextView.scrollIndicatorInsets = contentInsets
//	}
//	
//	func keyboardWillDisappear(notification: Notification){
//		let contentInsets = UIEdgeInsets.zero
//
//		self.noteTextView.contentInset = contentInsets
//		self.noteTextView.scrollIndicatorInsets = contentInsets
//	}
//}
//
//// MARK: - UITextViewDelegate
//extension NoteEditViewController: UITextViewDelegate{
//	func textViewDidBeginEditing(_ textView: UITextView) {
//		self.navigationItem.rightBarButtonItem = self.doneBarButton
//	}
//	func textViewDidEndEditing(_ textView: UITextView) {
//		self.navigationItem.rightBarButtonItem = nil
//		
//		self.writeCurrentTextToRealm()
//	}
//}

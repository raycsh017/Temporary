import UIKit
import SnapKit

class CalendarViewController: ViewController {

	let viewModel = CalendarViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		navigationItem.title = "달력"
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}

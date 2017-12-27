import UIKit
import SnapKit

class PrayerViewController: TableViewController {
	
	let viewModel: PrayerViewModel
	
	// MARK: Overriden Methods
	init(viewModel: PrayerViewModel) {
		self.viewModel = viewModel
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		let prayerType = viewModel.prayerType
		navigationItem.title = prayerType.koreanTitle
		
		tableViewUtility.register(cells: viewModel.cellConfigurators())
		tableViewUtility.reload()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) {
		return
	}
}

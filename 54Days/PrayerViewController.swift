import UIKit
import SnapKit

class PrayerViewController: TableViewController {
	
	// MARK: View Components
	
	// MARK: View Models

	var prayerType: PrayerType?
	
	// MARK: Overriden Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		tableViewUtility.delegate = self
		tableViewUtility.register(cells: cellConfigurators())
		tableViewUtility.show()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension PrayerViewController {
	override func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) {
//		if let cell = reusableCell as? PrayersListTableViewCell {
//			cell.delegate = self
//		}
	}
}

extension PrayerViewController {
	func cellConfigurators() -> [CellConfiguratorType] {
		var cellConfigurators = [CellConfiguratorType]()
		
		return cellConfigurators
	}
}


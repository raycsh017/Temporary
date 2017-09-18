import UIKit
import SnapKit

class PrayersListViewController: TableViewController {
	
	// MARK: View Components
	
	// MARK: View Models
	let viewModel = PrayersListViewModel()
	
	// MARK: Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		tableViewUtility.register(cells: viewModel.cellConfigurators)
		tableViewUtility.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PrayersListViewController {
	override func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) {
		if let cell = reusableCell as? PrayersListTableViewCell {
			cell.delegate = self
		}
	}
}

extension PrayersListViewController: PrayersListTableViewCellDelegate {
	func prayersListTableViewCell(_ cell: PrayersListTableViewCell, didSelectPrayer prayerType: PrayerType) {
		print(prayerType.title)
	}
}

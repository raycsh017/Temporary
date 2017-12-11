import UIKit
import SnapKit

class PrayerListViewController: TableViewController {
	// MARK: View Models
	let viewModel = PrayerListViewModel()
	
	// MARK: Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		navigationItem.title = "54days"
		
		tableViewUtility.register(cells: viewModel.cellConfigurators())
		tableViewUtility.reload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
}

extension PrayerListViewController {
	override func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) {
		if let cell = reusableCell as? PrayerListTableViewCell {
			cell.delegate = self
		}
	}
}

extension PrayerListViewController: PrayerListTableViewCellDelegate {
	func prayerListTableViewCell(_ cell: PrayerListTableViewCell, didSelectPrayer prayerType: PrayerType) {
		moveToPrayer(withType: prayerType)
	}
}

extension PrayerListViewController {
	// MARK: Routing
	fileprivate func moveToPrayer(withType prayerType: PrayerType) {
		let prayerViewModel = PrayerViewModel(prayerType: prayerType)
		let prayerViewController = PrayerViewController(viewModel: prayerViewModel)
		navigationController?.pushViewController(prayerViewController, animated: true)
	}
}

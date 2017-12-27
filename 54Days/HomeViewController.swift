import UIKit
import SnapKit

class HomeViewController: TableViewController {
	
	let viewModel = HomeViewModel()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
		navigationItem.title = "54Days"
		
		tableViewUtility.register(cells: viewModel.cellConfigurators())
		tableViewUtility.reload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) {
		if let cell = reusableCell as? PrayerEntryTableViewCell {
			cell.delegate = self
		}
	}
}

extension HomeViewController: PrayerEntryTableViewCellDelegate {
	func prayerEntryTableViewCell(_ cell: PrayerEntryTableViewCell, didSelectPrayer prayerType: PrayerType) {
		moveToPrayer(withType: prayerType)
	}
}

// MARK: Routing
extension HomeViewController {
	fileprivate func moveToPrayer(withType prayerType: PrayerType) {
		let prayerViewModel = PrayerViewModel(prayerType: prayerType)
		let prayerViewController = PrayerViewController(viewModel: prayerViewModel)
		navigationController?.pushViewController(prayerViewController, animated: true)
	}
}

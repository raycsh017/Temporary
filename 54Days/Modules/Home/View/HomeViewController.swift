import UIKit
import SnapKit

class HomeViewController: TableViewController {
	
	let viewModel = HomeViewModel()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
		navigationItem.title = "54Days"
		
		refreshPage()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		refreshPage()
	}
	
	override func tableViewUtility(_ tableViewUtility: TableViewUtility, reusableCell: UITableViewCell?, cellForRowAt indexPath: IndexPath) {
		if let cell = reusableCell as? HomePrayerEntryTableViewCell {
			cell.delegate = self
		}
	}
	
	private func refreshPage() {
		tableViewUtility.reloadData(withCellConfigurators: viewModel.cellConfigurators())
	}
}

extension HomeViewController: HomePrayerEntryTableViewCellDelegate {
	func prayerEntryTableViewCell(_ cell: HomePrayerEntryTableViewCell, didSelectPrayer prayerType: PrayerType) {
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

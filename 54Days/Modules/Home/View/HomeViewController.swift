import UIKit
import SnapKit

class HomeViewController: TableViewController {
	private let editButtonSize = CGSize(width: 48.0, height: 48.0)

	let viewModel: HomeViewModel

	init(viewModel: HomeViewModel, presentationType: PresentationType) {
		self.viewModel = viewModel
		super.init(presentationType: presentationType)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

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
		if let cell = reusableCell as? HomeRosaryProgressTableViewCell {
			cell.delegate = self
		} else if let cell = reusableCell as? HomePrayerEntryTableViewCell {
			cell.delegate = self
		}
	}

	private func refreshPage() {
		viewModel.getCellConfigurators { (cellConfigurators) in
			self.reloadData(withCellConfigurators: cellConfigurators)
		}
	}
}

extension HomeViewController: HomeRosaryProgressTableViewCellDelegate {
	func homeRosaryProgressTableViewCellDidTapCurrentRosaryPeriodCTA(_ cell: HomeRosaryProgressTableViewCell) {
		routeToRosaryPeriodInfo()
	}

	func HomeRosaryProgressTableViewCellDidTapSetNewRosaryPeriodCTA(_ cell: HomeRosaryProgressTableViewCell) {
		routeToRosaryForm()
	}
}

extension HomeViewController: HomePrayerEntryTableViewCellDelegate {
	func prayerEntryTableViewCell(_ cell: HomePrayerEntryTableViewCell, didSelectPrayer prayerType: PrayerType) {
		routeToPrayer(withType: prayerType)
	}
}

// MARK: Routing
extension HomeViewController {
	private func routeToPrayer(withType prayerType: PrayerType) {
		let viewModel = PrayerViewModel(prayerType: prayerType)
		let viewController = PrayerViewController(viewModel: viewModel, presentationType: .navigation)
		route(to: viewController)
	}

	private func routeToRosaryPeriodInfo() {
		let viewModel = RosaryPeriodInfoViewModel()
		let viewController = RosaryPeriodInfoViewController(viewModel: viewModel, presentationType: .modal)
		let _ = NavigationController(rootViewController: viewController)
		route(to: viewController)
	}

	private func routeToRosaryForm() {
		let viewModel = RosaryFormViewModel()
		let viewController = RosaryFormViewController(viewModel: viewModel, presentationType: .modal)
		route(to: viewController)
	}
}

extension HomeViewController: RosaryFormViewControllerDelegate {
	func rosaryFormViewControllerDidEditForm(_ viewController: RosaryFormViewController) {
		refreshPage()
	}
}

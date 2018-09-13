import UIKit
import SnapKit

class HomeViewController: TableViewController {
	private let editButtonSize = CGSize(width: 48.0, height: 48.0)
	
	lazy var editButton: Button = {
		let button = Button()
		button.backgroundColor = Color.White
		button.tintColor = Color.Black
		button.layer.cornerRadius = editButtonSize.width / 2.0
		button.setImage(UIImage(named: "ic_edit_white")?.withRenderingMode(.alwaysTemplate), for: .normal)
		button.addTarget(self, action: #selector(onEditButtonTap(_:)), for: .touchUpInside)
		return button
	}()
	
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

		safeAreaView.addSubview(editButton)

		editButton.snp.makeConstraints { (make) in
			make.right.equalToSuperview().offset(-Spacing.s16)
			make.bottom.equalToSuperview().offset(-Spacing.s16)
			make.size.equalTo(editButtonSize)
		}

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

	@objc func onEditButtonTap(_ sender: Any) {
		routeToRosaryForm()
	}
	
	private func refreshPage() {
		viewModel.getCellConfigurators { (cellConfigurators) in
			self.reloadData(withCellConfigurators: cellConfigurators)
		}
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
		navigationController?.pushViewController(viewController, animated: true)
	}

	private func routeToRosaryForm() {
		let viewModel = RosaryPeriodInfoViewModel()
		let viewController = RosaryPeriodInfoViewController(viewModel: viewModel, presentationType: .modal)
		let navigationController = NavigationController(rootViewController: viewController)
		self.navigationController?.present(navigationController, animated: true, completion: nil)
	}
}

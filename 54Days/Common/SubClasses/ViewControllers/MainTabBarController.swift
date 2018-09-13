import UIKit

class MainTabBarController: UITabBarController {
	private static let fixedTabBarIconInset = UIEdgeInsetsMake(5.0, 0.0, -5.0, 0.0)

	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		let homeViewModel = HomeViewModel()
		let homeViewController = HomeViewController(viewModel: homeViewModel, presentationType: .navigation)
		let homeTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ic_prayer"), tag: 0)
		homeTabBarItem.imageInsets = MainTabBarController.fixedTabBarIconInset
		homeViewController.tabBarItem = homeTabBarItem

		let homeNavigationController = NavigationController(rootViewController: homeViewController)
		homeNavigationController.prefersLargeTitles = true

		viewControllers = [homeNavigationController]

		selectedViewController = homeNavigationController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

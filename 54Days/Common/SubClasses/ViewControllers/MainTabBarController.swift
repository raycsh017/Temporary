import UIKit

class MainTabBarController: UITabBarController {
	
	let kFixedTabBarIconInset = UIEdgeInsetsMake(5.0, 0.0, -5.0, 0.0)
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		let homeViewController = HomeViewController()
		let homeTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ic_prayer"), tag: 0)
		homeTabBarItem.imageInsets = kFixedTabBarIconInset
		homeViewController.tabBarItem = homeTabBarItem
		
		let homeNavigationController = NavigationController(rootViewController: homeViewController)
		homeNavigationController.prefersLargeTitles = true
		
		let rosarySessionInfoViewController = RosarySessionInfoViewController()
		let rosarySessionInfoTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ic_calendar"), tag: 1)
		rosarySessionInfoTabBarItem.imageInsets = kFixedTabBarIconInset
		rosarySessionInfoViewController.tabBarItem = rosarySessionInfoTabBarItem
		
		viewControllers = [homeNavigationController, rosarySessionInfoViewController]
//		viewControllers = [calendarViewController]
		
//		selectedViewController = homeNavigationController
		selectedViewController = rosarySessionInfoViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

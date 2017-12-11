import UIKit

class MainTabBarController: UITabBarController {
	
	let kFixedTabBarIconInset = UIEdgeInsetsMake(5.0, 0.0, -5.0, 0.0)
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		let firstViewController = PrayerListViewController()
		let firstTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ic_prayer"), tag: 0)
		firstTabBarItem.imageInsets = kFixedTabBarIconInset
		firstViewController.tabBarItem = firstTabBarItem
		let firstTabNavigationController = UINavigationController(rootViewController: firstViewController)
		
		viewControllers = [firstTabNavigationController]
		selectedViewController = firstTabNavigationController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

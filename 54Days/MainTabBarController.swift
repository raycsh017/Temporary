import UIKit

class MainTabBarController: UITabBarController {
	
	let kFixedTabBarIconInset = UIEdgeInsetsMake(5.0, 0.0, -5.0, 0.0)
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		let firstViewController = PrayersListViewController()
		let firstTabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_prayer"), tag: 0)
		firstTabBarItem.imageInsets = kFixedTabBarIconInset
		firstViewController.tabBarItem = firstTabBarItem
		
		viewControllers = [firstViewController]
		selectedViewController = firstViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

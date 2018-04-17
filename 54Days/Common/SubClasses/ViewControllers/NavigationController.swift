//
//  NavigationController.swift
//  54Days
//
//  Created by Sang Hyuk Cho on 12/26/17.
//  Copyright © 2017 sang. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
	
	var prefersLargeTitles: Bool = false {
		didSet {
			navigationBar.prefersLargeTitles = prefersLargeTitles
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

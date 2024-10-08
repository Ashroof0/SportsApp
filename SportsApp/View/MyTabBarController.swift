//
//  NewtabViewController.swift
//  SportsApp
//
//  Created by Enas Mohamed on 18/08/2024.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Instantiate the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Instantiate the view controllers using their Storyboard IDs
        let viewController1 = storyboard.instantiateViewController(withIdentifier: "SportsViewController")
        let leaguesViewController = storyboard.instantiateViewController(withIdentifier: "LeaguesViewController")
        
        viewController1.tabBarItem = UITabBarItem(title: "Sports", image: UIImage(systemName: "1.circle"), tag: 0)
        leaguesViewController.tabBarItem = UITabBarItem(title: "FAV", image: UIImage(systemName: "2.circle"), tag: 1)
        
        // Assign the view controllers to the tab bar
        self.viewControllers = [viewController1, leaguesViewController]
    }
}

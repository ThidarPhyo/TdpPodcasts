//
//  MainTabBarController.swift
//  TdpPodcasts
//
//  Created by Thidar Phyo on 2/22/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        tabBar.tintColor = .purple
        
        UINavigationBar.appearance().prefersLargeTitles = true
        view.backgroundColor = .white
    
        setupViewControllers()
    }
    
    //MARK:- Setup Functions
    
    func setupViewControllers() {
        viewControllers = [
            generateNavigationController(for: PodcastSearchController(), title: "Search", image: #imageLiteral(resourceName: "search")),
            generateNavigationController(for: ViewController(), title: "Favourites", image: #imageLiteral(resourceName: "favorites")),
            generateNavigationController(for: ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        
        ]
    }
    
    //MARK:- Helper Functions
    
    fileprivate func generateNavigationController(for rootViewController : UIViewController, title: String, image: UIImage ) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        //navController.navigationBar.prefersLargeTitles = true
        
        //change color of title
        //navController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.blue]
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
        
    }


}

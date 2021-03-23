//
//  TabBarViewController.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/23/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let vc1 = HomeViewController()
        let vc2 = SearchViewController()
        let vc3 = LibraryViewController()
        
        vc1.title = "Browse"
        vc2.title = "Search"
        vc2.title = "Library"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc1)
        let nav3 = UINavigationController(rootViewController: vc1)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
        
        
        
        vc1.navigationItem.largeTitleDisplayMode  = .always
        vc2.navigationItem.largeTitleDisplayMode  = .always
        vc3.navigationItem.largeTitleDisplayMode  = .always
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
    
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
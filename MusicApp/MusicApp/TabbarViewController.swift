//
//  TabbarViewController.swift
//  MusicApp
//
//  Created by Lauv Edward on 24/07/2021.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    var homeVC: HomeViewController!
    var library: LibraryViewController!
    var search: SearchViewController!
    var setting: SettingViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.tintColor = UIColor.white
        self.tabBar.isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.grayColorMain // your color

        homeVC = HomeViewController()
        homeVC.tabBarItem.title = "home".localized
        homeVC.tabBarItem.image = UIImage(named: "home_icon")
        library = LibraryViewController()
        library.tabBarItem.title = "library".localized
        library.tabBarItem.image = UIImage(named: "library_icon")
        search = SearchViewController()
        search.tabBarItem.title = "search".localized
        search.tabBarItem.image = UIImage(named: "search_icon")
        setting = SettingViewController()
        setting.tabBarItem.title = "setting".localized
        setting.tabBarItem.image = UIImage(named: "setting_icon")
        
        self.viewControllers = [homeVC, library, search, setting]
    }
}

extension TabbarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: TabbarViewController.self) {
            let vc = HomeViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            return false
        }
        return true
    }
}

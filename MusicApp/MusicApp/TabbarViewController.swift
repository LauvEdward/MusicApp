//
//  TabbarViewController.swift
//  MusicApp
//
//  Created by Lauv Edward on 24/07/2021.
//

import UIKit

@available(iOS 13.0, *)
class TabbarViewController: UITabBarController {
    private var homeVC: HomeViewController!
    private var library: LibraryViewController!
    private var search: SearchViewController!
    private var setting: SettingViewController!
    private var playMusicView = PlayMusicTabbar()
    var isPlay: Bool! {
        didSet {
            if isPlay {
                self.view.addSubview(playMusicView)
            } else {
                if let viewWithTag = self.view.viewWithTag(1) {
                        viewWithTag.removeFromSuperview()
                    }
            }
        }
    }
//    private var playMusicView: UIView = {
//        let view = UIView()
//        view.tag = 1
//        view.backgroundColor = .blue
//        return view
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.tintColor = UIColor.white
        self.tabBar.alpha = 1
        UITabBar.appearance().barTintColor = UIColor.grayColorMain // your color
        isPlay = true
        playMusicView.frame = CGRect(x: self.tabBar.bounds.minX, y: self.view.bounds.height - 2 * self.tabBar.bounds.size.height, width: self.tabBar.bounds.width, height: self.tabBar.bounds.height)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapPlayMusicView))
        playMusicView.addGestureRecognizer(tap)
        homeVC = HomeViewController()
        homeVC.tabBarItem.title = "home".localized
        homeVC.tabBarItem.image = UIImage(named: "home_icon")
        homeVC.delegate = self
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
    
    @objc func tapPlayMusicView() {
        let vc = PlayMusicViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

@available(iOS 13.0, *)
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

@available(iOS 13.0, *)
extension TabbarViewController: callbackTabbar {
    func callback() {
        self.isPlay = !self.isPlay
    }
}

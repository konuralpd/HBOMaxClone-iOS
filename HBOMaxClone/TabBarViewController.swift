//
//  ViewController.swift
//  HBOMaxClone
//
//  Created by Mac on 16.10.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        configureTabBars()
        
    }

    func configureTabBars() {
        
       
        let vc1 = UINavigationController(rootViewController: MainViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: DownloadedsViewController())
        
        vc1.tabBarItem.image = UIImage(named: "home")
        vc2.tabBarItem.image = UIImage(named: "search")
        vc3.tabBarItem.image = UIImage(named: "download")
        
        vc1.title = "Anasayfa"
        vc2.title = "Arama"
        vc3.title = "Kaydedilenler"
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = UIColor(named: "hboPurple")
        
        setViewControllers([vc1, vc2, vc3], animated: true)
    }

}


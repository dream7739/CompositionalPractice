//
//  CompositionalTabBar.swift
//  CompositionalPractice
//
//  Created by 홍정민 on 7/18/24.
//

import UIKit

final class CompositionalTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.selected.iconColor = .systemPink
        appearance.stackedLayoutAppearance.normal.iconColor = .systemGray
        appearance.backgroundColor = .white
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
     
        let setting = UITabBarItem(title: "", image: UIImage(systemName: "heart"), tag: 0)
        let travel = UITabBarItem(title: "", image: UIImage(systemName: "heart.fill"), tag: 1)
        
        let settingVC = UINavigationController(rootViewController: SettingViewController())
        let travelVC = UINavigationController(rootViewController: TravelTalkViewController())
        
        settingVC.tabBarItem = setting
        travelVC.tabBarItem = travel
        
        setViewControllers([settingVC, travelVC], animated: true)
       
    }
}

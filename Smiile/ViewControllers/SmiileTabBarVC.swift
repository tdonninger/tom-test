//
//  SmiileTabBarVC.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

class SmiileTabBarVC: UITabBarController {
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let homeVC = HomeVC()
        homeVC.tabBarItem = UITabBarItem(title: tr("common.home"), image: UIImage(named: "icon-home"), tag: 0)
        
        let requestVC = RequestVC()
        requestVC.tabBarItem = UITabBarItem(title: tr("common.request"), image: UIImage(named: "icon-request"), tag: 1)
        
        let messageVC = MessageVC()
        messageVC.tabBarItem = UITabBarItem(title: tr("common.message"), image: UIImage(named: "icon-chat"), tag: 2)
        
        let notificationVC = NotificationsVC()
        notificationVC.tabBarItem = UITabBarItem(title: tr("common.notification"), image: UIImage(named: "icon-notification"), tag: 3)
        
        let menuVC = MenuVC()
        menuVC.tabBarItem = UITabBarItem(title: tr("common.menu"), image: UIImage(named: "icon-menu"), tag: 4)
        
        self.viewControllers = [UINavigationController(rootViewController: homeVC),
                                      UINavigationController(rootViewController: requestVC),
                                      UINavigationController(rootViewController: messageVC),
                                      UINavigationController(rootViewController: notificationVC),
                                      UINavigationController(rootViewController: menuVC)]
    }
}

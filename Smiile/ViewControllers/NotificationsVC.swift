//
//  NotificationsVC.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

class NotificationsVC: UIViewController {

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = tr("common.notification")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Functions
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor.smiileExtraLightGrey
    }

}

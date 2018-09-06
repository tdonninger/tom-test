//
//  SplashVC.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit
import KeychainAccess

class SplashVC: UIViewController {

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Functions
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor.smiileExtraLightGrey
        
        let imageView = UIImageView(image: UIImage(named:"logo"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.height.equalTo(300)
        }
    }
    
    func connect() {
        if UserService.autoConnect() {
            Configuration.appDelegate.didConnect(true)
        } else {
            Configuration.appDelegate.didConnect(false)
        }
    }
}

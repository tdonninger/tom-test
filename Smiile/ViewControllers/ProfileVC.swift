//
//  ProfileVC.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = tr("common.profile")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Functions
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor.smiileExtraLightGrey
        
        let closeButton = ActionButton(.close)
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.right.equalTo(view.safeAreaLayoutGuide).inset(Theme.MarginDefault)
        }
        closeButton.addTarget { (button) in
            self.dismiss(animated: true, completion: nil)
        }
    }

}

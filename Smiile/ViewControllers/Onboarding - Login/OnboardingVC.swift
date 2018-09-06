//
//  OnboardingVC.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit
import SnapKit

class OnboardingVC: UIViewController {
    
    //MARK: Variables
    private let contentView = UIStackView()

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Functions
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor.smiileExtraLightGrey

        createScrollView()
        createContent()
        createButtons()
    }
    
    func createScrollView() {
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .always

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
        }
        contentView.alignment = .fill
    }
    
    func createContent() {
        // 4 screens max, too long otherwise
        let firstScreen = OnboardingScreenView(.info1)
        addView(firstScreen)
        let secondScreen = OnboardingScreenView(.info2)
        addView(secondScreen)
        let thirdScreen = OnboardingScreenView(.info3)
        addView(thirdScreen)
        let fourthScreen = OnboardingScreenView(.info4)
        addView(fourthScreen)
    }
    
    func createButtons() {
        let registerButton = ActionButton(.white)
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Theme.MarginDefault)
            make.centerX.equalTo(view)
        }
        registerButton.setTitle(tr("onboarding.register"))
        registerButton.addTarget { (button) in
            self.goToRegisterView()
        }
        
        let loginButton = ActionButton(.blue)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(registerButton.snp.top).offset(-Theme.MarginDefault)
            make.centerX.equalTo(view)
        }
        loginButton.setTitle(tr("onboarding.login"))
        loginButton.addTarget { (button) in
            self.goToLoginVC()
        }
        
        let facebookButton = ActionButton(.facebook)
        view.addSubview(facebookButton)
        facebookButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(loginButton.snp.top).offset(-Theme.MarginDefault)
            make.centerX.equalTo(view)
        }
        facebookButton.setTitle(tr("onboarding.fb.login"))
        facebookButton.addTarget { (button) in
            UserService.loginWithFacebook(self, completion: { (error, user) in
                if let error = error {
                    print("error : \(error.localizedDescription)")
                } else {
                    Configuration.appDelegate.didConnect(true)
                }
            })
        }
    }
    
    func addView(_ myView: UIView) {
        contentView.addArrangedSubview(myView)
        myView.snp.makeConstraints { (make) in
            make.width.height.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func goToRegisterView() {
        let controller = RegisterVC()
        present(controller, animated: true, completion: nil)
    }
    
    func goToLoginVC() {
        let controller = LoginVC()
        present(controller, animated: true, completion: nil)
    }
}

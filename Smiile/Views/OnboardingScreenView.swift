//
//  OnboardingScreenView.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

enum OnboardingScreenType {
    case info1, info2, info3, info4
}

class OnboardingScreenView: CustomView {
    //MARK: Variables
    var type: OnboardingScreenType?
    var infoText: String = ""
    var imageName: String = ""
    private let infoLabel = UILabel()
    private let imageView = UIImageView()

    
    //MARK: Init
    init(_ type: OnboardingScreenType) {
        super.init(frame: CGRect())
        self.type = type
        switch type {
        case .info1:
            infoText = tr("onboarding.info.1")
            imageName = "onboarding-image1"
            break
        case .info2:
            infoText = tr("onboarding.info.2")
            //set different image according the content
            imageName = "onboarding-image1"
            break
        case .info3:
            infoText = tr("onboarding.info.3")
            //set different image according the content
            imageName = "onboarding-image1"
            break
        case .info4:
            infoText = tr("onboarding.info.4")
            //set different image according the content
            imageName = "onboarding-image1"
            break
        }
        
        updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func commonInit () {
        backgroundColor = UIColor.smiileExtraLightGrey
        clipsToBounds = true

        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(Theme.MarginExtraBig*2)
            make.left.right.equalTo(self).inset(Theme.MarginBig)
        }
        infoLabel.numberOfLines = 0
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(300)
            make.center.equalTo(self)
        }
        imageView.contentMode = .scaleAspectFit
    }
    
    //MARK: Functions
    func updateView() {
        infoLabel.setText(infoText, font: UIFont.systemFont(ofSize: 30), color: UIColor.smiileBlue, textAlignment: .left)
        imageView.image = UIImage(named: imageName)
    }
}

//
//  ActionButton.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

class ActionButton: CustomButton {
    
    //MARK: Variables
    enum Style {
        case blue, white, close, facebook
    }
    
    var style : Style {
        didSet {
            updateStyle()
        }
    }
    
    //MARK: Init
    init(_ style: Style = .blue) {
        self.style = style
        super.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func commonInit() {
        super.commonInit()
        self.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(280)
            make.height.equalTo(Theme.ButtonHeight)
        }
        
        self.titleLabel!.font = UIFont.systemFont(ofSize: Theme.FontSizeDefault)
        clipCornerRadius(Theme.ButtonHeight / 2.0)
        updateStyle()
    }
    
    //MARK: Functions
    func updateStyle () {
        switch style {
        case .blue:
            self.layer.borderColor = nil
            self.backgroundColor = UIColor.smiileBlue
            self.setTitleColor(UIColor.white)
            break
        case .white:
            self.layer.borderColor = UIColor.smiileBlue.cgColor
            self.layer.borderWidth = 1.0
            self.backgroundColor = nil
            self.setTitleColor(UIColor.smiileBlue)
            break
        case .close:
            self.backgroundColor = UIColor.smiileBlue
            self.setTitleColor(UIColor.white)
            self.setTitle("X")
            self.snp.remakeConstraints { (make) in
                make.width.height.equalTo(40)
            }
            clipCornerRadius(40 / 2.0)
        case .facebook:
            self.layer.borderColor = nil
            self.backgroundColor = UIColor(hexString: "#3b5998")
            self.setTitleColor(UIColor.white)
            break
        }
    }
    
}

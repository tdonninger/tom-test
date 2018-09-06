//
//  MenuCell.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

class MenuCell: CustomUITableViewCell {

    //MARK: Variables
    var notificationsLabel = UILabel()
    
    //MARK: Helper
    class func height () -> CGFloat {
        return 44
    }

    //MARK: Init
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func commonInit() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.textLabel?.setFont(UIFont.systemFont(ofSize: 15), color: UIColor.smiileBlue)
        
        
        let labelContainer = UIView()
        self.contentView.addSubview(labelContainer)
        labelContainer.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).inset(15)
            make.centerY.equalTo(self.contentView)
            make.height.equalTo(22)
            make.width.greaterThanOrEqualTo(22)
        }
        labelContainer.clipCornerRadius(22 / 2)
        
        
        labelContainer.addSubview(notificationsLabel)
        notificationsLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(labelContainer)
            make.left.right.equalTo(labelContainer).inset(7)
        }
        notificationsLabel.setFont(UIFont.systemFont(ofSize: 15), color: UIColor.smiileBlue, textAlignment: .center)
    }

}

//
//  HomeTableViewHeader.swift
//  Smiile
//
//  Created by Thomas Donninger on 06/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

import UIKit
import SnapKit

protocol HomeTableHeaderViewDelegate {
    func didTapHeaderViewAtSection(_ section: Int)
}

class HomeTableViewHeader: UITableViewHeaderFooterView {
    
    //MARK: Variables
    var delegate: HomeTableHeaderViewDelegate!
    let titleLabel = UILabel()
    
    //MARK: Helper
    class func headerIdentifier () -> String {
        return NSStringFromClass(self)
    }
    
    //MARK: Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.right.equalTo(self).inset(Theme.MarginDefault)
        }
        
        let topView = UIView()
        addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel)
            make.left.right.equalTo(self)
            make.height.equalTo(1)
        }
        topView.backgroundColor = UIColor.smiileBlue
        
        let bottomView = UIView()
        addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalTo(titleLabel.snp.bottom).offset(-1)
            make.left.right.equalTo(self)
            make.height.equalTo(1)
        }
        bottomView.backgroundColor = UIColor.smiileBlue
    }
    
    //MARK: Functions
    func setHeaderTitle(_ title: String?) {
        guard let title = title else { return }
        let attrText = NSMutableAttributedString(string: title, attributes: [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15),
            NSAttributedStringKey.foregroundColor: UIColor.smiileBlue
            ])
        attrText.append(NSAttributedString(string: "  " + tr("home.section.see_all"), attributes: [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13),
            NSAttributedStringKey.foregroundColor: UIColor.darkGray
            ]))
        addShowAllGesture()
        
        titleLabel.attributedText = attrText
    }
    
    func addShowAllGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapHeaderView))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapHeaderView() {
        delegate.didTapHeaderViewAtSection(self.tag)
    }
}

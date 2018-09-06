//
//  NewsCollectionViewCell.swift
//  Smiile
//
//  Created by Thomas Donninger on 06/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCollectionViewCell: CustomUICollectionViewCell {
    
    //MARK: Variables
    var news: SmiileNews? {
        didSet {
            reloadData()
        }
    }
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    //MARK: Helper
    class func contentSize () -> CGSize {
        return CGSize(width: 246.0, height: 180.0)
    }

    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: CGRect(origin: CGPoint(), size: NewsCollectionViewCell.contentSize()))
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func commonInit() {
        super.commonInit()
        
        self.backgroundColor = UIColor.clear
        self.contentView.clipsToBounds = true
        
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.contentView).inset(Theme.MarginDefault)
            make.left.right.equalTo(self.contentView)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipCornerRadius(5)
        
        self.contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(imageView).inset(Theme.MarginBig)
            make.right.lessThanOrEqualTo(imageView).inset(Theme.MarginBig)
            make.bottom.equalTo(imageView.snp.bottom).inset(Theme.MarginDefault)
        }
        subtitleLabel.setFont(UIFont.systemFont(ofSize: 14), color: UIColor.white, backgroundColor: UIColor.smiileBlue)
        
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-4)
            make.left.right.equalTo(self.contentView).inset(Theme.MarginBig)
        }
        titleLabel.setFont(UIFont.systemFont(ofSize: 22), color: UIColor.white)
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = false
    }
    
    //MARK: Functions
    func reloadData () {
        if let news = news {
            titleLabel.text = news.title
            if let tag = news.tag, let name = tag.name {
                subtitleLabel.text = name.uppercased()
            }
            if let imageString = news.imageString, let url = URL(string: imageString) {
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            }
        }
    }
}

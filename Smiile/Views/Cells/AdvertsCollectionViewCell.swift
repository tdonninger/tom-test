//
//  AdvertsCollectionViewCell.swift
//  Smiile
//
//  Created by Thomas Donninger on 06/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

class AdvertsCollectionViewCell: CustomUICollectionViewCell {
    
    //MARK: Variables
    var adverts: SmiileAdverts? {
        didSet {
            reloadAdverts()
        }
    }
    private let profileImageView = UIImageView()
    private let locationLabel = UILabel()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let priceLabel = UILabel()
    
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
        
        backgroundColor = UIColor.clear
        contentView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(contentView).inset(Theme.MarginDefault)
            make.left.right.equalTo(contentView)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipCornerRadius(5)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.smiileBlue.cgColor
        
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(imageView).inset(Theme.MarginDefault)
            make.width.height.equalTo(40)
        }
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipCornerRadius(40/2.0)
        profileImageView.layer.borderColor = UIColor.smiileBlue.cgColor
        profileImageView.layer.borderWidth = 2
        
        contentView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { (make) in
            make.top.right.equalTo(imageView).inset(Theme.MarginDefault)
        }
        locationLabel.setFont(UIFont.systemFont(ofSize: 12), color: UIColor.smiileBlue, textAlignment: .right)
        
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(imageView).inset(Theme.MarginDefault)
            make.width.lessThanOrEqualTo(imageView).dividedBy(2)
            make.bottom.equalTo(imageView.snp.bottom).inset(Theme.MarginDefault)
        }
        subtitleLabel.setFont(UIFont.systemFont(ofSize: 14), color: UIColor.white, backgroundColor: UIColor.smiileBlue)
        
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(imageView.snp.right).inset(Theme.MarginDefault)
            make.width.lessThanOrEqualTo(imageView).dividedBy(2)
            make.bottom.equalTo(imageView.snp.bottom).inset(Theme.MarginDefault)
        }
        priceLabel.setFont(UIFont.systemFont(ofSize: 14), color: UIColor.smiileBlue)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-4)
            make.left.right.equalTo(contentView).inset(Theme.MarginDefault)
        }
        titleLabel.setFont(UIFont.systemFont(ofSize: 22), color: UIColor.white)
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = false
    }
    
    //MARK: Functions
    func reloadAdverts () {
        if let adverts = adverts {
            if let user = adverts.user, let profilePicString = user.imageString, let url = URL(string: profilePicString) {
                profileImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "icon-profile"))
            }
            locationLabel.text = adverts.city
            titleLabel.text = adverts.title
            if let tag = adverts.tag, let name = tag.name {
                subtitleLabel.text = name.uppercased()
            }
            if let price = adverts.price {
                priceLabel.text = price.concatString(text: "€", char: " ")
            }
            if let imageString = adverts.imageString, let url = URL(string: imageString) {
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            }
        }
    }
}

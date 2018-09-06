//
//  HomeCell.swift
//  Smiile
//
//  Created by Thomas Donninger on 06/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

class HomeCell: CustomUITableViewCell {
    //MARK: Variables
    var collectionView: HomeCollectionView!
    
    //MARK: Init
    override func commonInit() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.smiileExtraLightGrey
        self.contentView.backgroundColor = self.backgroundColor
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        collectionView = HomeCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(contentView)
        }
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.cellIdentifier())
        collectionView.register(AdvertsCollectionViewCell.self, forCellWithReuseIdentifier: AdvertsCollectionViewCell.cellIdentifier())
        collectionView.backgroundColor = UIColor.smiileExtraLightGrey
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        layoutMargins = UIEdgeInsets.zero
    }
    
    //MARK: Functions
    func setCollectionViewDataSourceDelegate(dataSourceDelegate delegate: UICollectionViewDelegate & UICollectionViewDataSource, index: NSInteger) {
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.dataSource = delegate
        collectionView.delegate = delegate
        collectionView.tag = index
        collectionView.reloadData()
    }

}

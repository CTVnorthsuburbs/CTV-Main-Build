//
//  HorizontalTableViewCell.swift
//  HalfTunes
//
//  Created by William Ogura on 10/21/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit


class HorizontalTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
      
    
    
}

extension HorizontalTableViewCell {
    
    func setCollectionViewDataSourceDelegate
        <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set {
            collectionView.contentOffset.x = newValue
        }
        
        get {
            return collectionView.contentOffset.x
        }
    }
}

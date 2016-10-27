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
    
    @IBOutlet weak var seeAllLabel: UILabel!
      
    @IBOutlet weak var sectionLabel: UILabel!
    
    
}

extension HorizontalTableViewCell {
    
    func setCollectionViewDataSourceDelegate
        <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        
        /*  second block replaces this block in order to optimize scroll
        collectionView.tag = row
        collectionView.reloadData()
        */ 
        
        
        if collectionView.tag != row {
            collectionView.tag = row
            // Stops collection view if it was scrolling.
            collectionView.setContentOffset(collectionView.contentOffset, animated:false)
            collectionView.reloadData()
        }
        
        
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

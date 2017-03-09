//
//  HorizontalTableViewCell.swift
//  HalfTunes
//
//  Created by William Ogura on 10/21/16.
// 
//

import UIKit


class HorizontalTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var seeAllButton: UIButton!
      
    @IBOutlet weak var sectionLabel: UILabel!
    
    func disableSeeAllButton() {
        
        
        
        seeAllButton.isHidden = true
        
        
    }
}

extension HorizontalTableViewCell {
    
    func setCollectionViewDataSourceDelegate
        <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
    
        
        /*
        collectionView.tag = row
        collectionView.reloadData()
        */
        
        
        
        if collectionView.tag != row {
            collectionView.tag = row
            // Stops collection view if it was scrolling.
           // collectionView.setContentOffset(collectionView.contentOffset, animated:false)
            collectionView.reloadData()
        }
        
        
    }
    
    func reloadCell() {
        
        
        
        self.collectionView.reloadData()
        self.collectionView.setContentOffset(CGPoint.zero, animated: false)
        
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

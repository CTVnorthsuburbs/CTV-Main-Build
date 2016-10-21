//
//  HorizontalTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 10/21/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

class HorizontalTableViewController: UITableViewController {
    
    
 //   let model = generateRandomData()
    var storedOffsets = [Int: CGFloat]()
    
    var search = VideoSearch()
    
    var model = [Video]()
    
    
    override func viewDidLoad() {
        model = search.getRecentLimited()
      
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        
        return "Featured Events"
    }
    
 
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? HorizontalTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: (indexPath as NSIndexPath).row)
        tableViewCell.collectionViewOffset = storedOffsets[(indexPath as NSIndexPath).row] ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? HorizontalTableViewCell else { return }
        
        storedOffsets[(indexPath as NSIndexPath).row] = tableViewCell.collectionViewOffset
    }
}

extension HorizontalTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
       // cell.backgroundColor = model[collectionView.tag][(indexPath as NSIndexPath).item]
        var cells : HorizontalCollectionViewCell
        
        
        cells = cell as! HorizontalCollectionViewCell
        
        
        if ((model[indexPath.item].fileName) != nil) {
        cells.thumbnail.image = search.getThumbnail(id: (model[indexPath.item].fileName!))
            
            cells.thumbnail.setRadius(radius: 4)
            
        cells.titleLabel.text = model[indexPath.item].title
            
            cells.dateLabel.text = convertDateToString(date: model[indexPath.item].eventDate!)
            
           
            
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }

   }


extension UIImage{
    
    func alpha(value:CGFloat)->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
}




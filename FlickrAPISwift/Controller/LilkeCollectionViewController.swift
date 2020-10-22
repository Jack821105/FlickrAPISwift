//
//  LilkeCollectionViewController.swift
//  FlickrAPISwift
//
//  Created by 許自翔 on 2020/10/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class LilkeCollectionViewController: UICollectionViewController {

    var photoList:SearchData?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        //控制cell
        let itemSpace: CGFloat = 0
        let columnCount: CGFloat = 2
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let width = floor((collectionView.bounds.width  - itemSpace * (columnCount)) / columnCount)
        print("width",width, collectionView.bounds)
        flowLayout?.itemSize = CGSize(width: width, height: width)
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = itemSpace
        flowLayout?.minimumLineSpacing = itemSpace
        flowLayout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)


    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoList?.photos.photo.count ?? 100
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(LikeCollectionViewCell.self)", for: indexPath) as? LikeCollectionViewCell
        
        cell?.lbTitle.text = "test"
        cell?.ivPhoto.image = UIImage(systemName: "questionmark.circle")
    
        // Configure the cell
        if let cell = cell {
            return cell
        }else {
            return CollectionViewCell()
        }
        
    }

}

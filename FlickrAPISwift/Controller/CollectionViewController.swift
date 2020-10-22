//
//  CollectionViewController.swift
//  FlickrAPISwift
//
//  Created by 許自翔 on 2020/10/20.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    //宣告區
    var page:String?
    var text:String?
    var isLoading = false
    var photoList:SearchData?
    var refreshControl:UIRefreshControl!
    var pages = 1
    var hasMore = true
    var isLoadingMore = false
    var containerView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //控制cell
        let itemSpace: CGFloat = 2
        let columnCount: CGFloat = 2
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let width = floor((collectionView.bounds.width  - itemSpace * (columnCount)) / columnCount)
        print("width",width, collectionView.bounds)
        flowLayout?.itemSize = CGSize(width: width, height: width)
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = itemSpace
        flowLayout?.minimumLineSpacing = itemSpace
        flowLayout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        //第一次進來抓取資料
        Network.shared.fetchData(pageCount: page! , text: text!, page: pages) { (Photo) in
            if Photo != nil{
                self.photoList = Photo
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        //下拉刷新
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: UIControl.Event.valueChanged)
        collectionView.addSubview(refreshControl)
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    //更新資料
    @objc func loadData(){
        showLoadingView()
        isLoadingMore = true
        Network.shared.fetchData(pageCount: page! , text: text!, page: pages) { (Photo) in
            if Photo != nil{
                self.photoList?.photos.photo.append(contentsOf: Photo.photos.photo)
                self.dismissLoadingView()
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        isLoadingMore = false
    }
    
    //滑動底部判斷
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            guard hasMore, !isLoadingMore else { return }
            pages += 1
            loadData()
        }
    }
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList?.photos.photo.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell.self)", for: indexPath) as? CollectionViewCell
        
        cell?.photo = photoList?.photos.photo[indexPath.row]
        cell?.update()
        
        if let cell = cell {
            return cell
        }else {
            return CollectionViewCell()
        }
    }
    
    
    //上拉特效
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    //上拉特效取消
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    
    
}



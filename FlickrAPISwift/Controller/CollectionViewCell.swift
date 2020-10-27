//
//  CollectionViewCell.swift
//  FlickrAPISwift
//
//  Created by 許自翔 on 2020/10/20.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let imageCache = NSCache<NSURL, UIImage>()
    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    //    @IBOutlet weak var btLike: UIButton!
    var photo:Photo?
    var photoData = [Photo]()
    var userDefaults = UserDefaults.standard
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        
        if let image = imageCache.object(forKey: url as NSURL) {
            print("測試快取")
            completion(image)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: url as NSURL)
                print("測試第一次")
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func update() {
        let id = photo?.id
        lbTitle.text = photo?.title ?? "nil"
        ivPhoto.image = UIImage(systemName: "questionmark.circle")
        fetchImage(url: photo!.imageUrl) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                /*判斷id是否一樣*/
                if id == self.photo?.id{
                    self.ivPhoto.image = image
                }
            }
        }
    }
    
    
    @IBAction func actionLike(_ sender: Any) {
        
        Network.shared.addMyLike(outPhoto: photo!) { (i) in
            if i == 1{
                print("上傳成功")
            }else{
                print("上傳失敗")
            }
        }
        
    }
    
    
}

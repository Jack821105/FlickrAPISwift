//
//  LikeCollectionViewCell.swift
//  FlickrAPISwift
//
//  Created by 許自翔 on 2020/10/21.
//

import UIKit

class LikeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivPhoto: UIImageView!
    
    var photo:LikePhoto?
    
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
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
    
    @IBAction func actionDeleted(_ sender: Any) {
        
        Network.shared.deletedMyLike(outLikePhoto: photo!) { (rep) in
            if rep == 1{
                print("成功")
            }else{
                print("失敗")
            }
        }
        
    }
    
    
}

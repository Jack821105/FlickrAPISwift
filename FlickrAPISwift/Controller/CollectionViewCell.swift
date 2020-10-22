//
//  CollectionViewCell.swift
//  FlickrAPISwift
//
//  Created by 許自翔 on 2020/10/20.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btLike: UIButton!
    var photo:Photo?

    
    
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
    
    
    
    
    
    
    
    @IBAction func actionLike(_ sender: Any) {
     
        
     
        
    }
}
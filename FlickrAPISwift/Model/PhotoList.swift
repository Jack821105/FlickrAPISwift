//
//  PhotoList.swift
//  FlickrAPISwift
//
//  Created by 許自翔 on 2020/10/20.
//

import Foundation

struct Photo: Codable {
    let farm: Int
    let secret: String
    let id: String
    let server: String
    let title: String
    var imageUrl: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
}

struct LikePhoto: Codable {
    let farm: String
    let secret: String
    let id: String
    let server: String
    let title: String
    var imageUrl: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
    
}



struct PhotoData: Codable {
    var photo: [Photo]
}

struct SearchData: Codable {
    var photos: PhotoData
}

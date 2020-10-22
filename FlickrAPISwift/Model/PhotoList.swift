//
//  PhotoList.swift
//  FlickrAPISwift
//
//  Created by 許自翔 on 2020/10/20.
//

import Foundation


struct Photo: Decodable {
    let farm: Int
    let secret: String
    let id: String
    let server: String
    let title: String
    var imageUrl: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
}

struct PhotoData: Decodable {
    var photo: [Photo]
}

struct SearchData: Decodable {
    var photos: PhotoData
}

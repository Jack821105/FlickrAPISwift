//
//  Photo.swift
//  FlickrAPISwift
//
//  Created by 許自翔 on 2020/10/20.
//

import Foundation

struct Photo:Codable {
    let page:Int
    let pages:Int
    let perpage:Int
    let total:Int
    let photo:[PhotoList]
}

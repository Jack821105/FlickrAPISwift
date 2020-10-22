//
//  Network.swift
//  FlickrAPISwift
//
//  Created by 許自翔 on 2020/10/20.
//

import Foundation



class Network{
    
    static let shared = Network()
    let flickrKey = "3f92e427e0f27a1c0ef70176acf1c848"
    
    func fetchData(pageCount inPageCount:String,text inText:String,page inPage:Int ,handler: @escaping (SearchData)->Void){
        
        let url=getURL_Path(inPageCount, text: inText, page: inPage)
        var req = URLRequest(url: url!)
        req.httpMethod = "GET"
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let error = error{
                print("error:\(error)")
            }else if let response = response , let data = data{
                print("response:\(response)")
                let decoder = try! JSONDecoder().decode(SearchData.self, from: data)
                handler(decoder)
            }
        }.resume()
    }
    func getURL_Path(_ pageCount: String, text: String,page:Int) -> URL?{
        //處理中文字串
        let newText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let urlPath = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(flickrKey)&format=json&nojsoncallback=1&per_page=\(pageCount)&text=\(newText)&page=\(page)")
        else {
            return nil
        }
        return urlPath
    }
    
}

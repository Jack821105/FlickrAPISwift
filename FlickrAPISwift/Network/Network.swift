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
    
    
    //加入我的最愛
    func addMyLike(outPhoto inPhoto:Photo ,handler:@escaping (Int) -> Void) {
        struct keyvalue:Codable{
            let data : Photo
        }
        var url = URL(string: "https://sheetdb.io/api/v1/q5xzqpddkdsmm")
        var req = URLRequest(url: url!)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try? JSONEncoder().encode(keyvalue(data: inPhoto))
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let error = error{
                print("error:\(error.localizedDescription)")
            }else if let response = response, let data = data{
                print("response:\(response)")
                if let decoder = try? JSONDecoder().decode([String:Int].self, from: data){
                    if decoder["created"] == 1{
                        handler(1)
                    }else{
                        handler(0)
                    }
                }
            }
        }.resume()
        
    }
    
    //取讀我的最愛
    func getMyLike(handler:@escaping ([LikePhoto]) -> Void) {
        
        var url = URL(string: "https://sheetdb.io/api/v1/q5xzqpddkdsmm")
        var req = URLRequest(url: url!)
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let error = error {
                print("error :\(error.localizedDescription)")
            }else if let response = response, let data = data{
                print("response:\(response)")
                let decoder = try! JSONDecoder().decode([LikePhoto].self, from: data)
                if let decoder = try? JSONDecoder().decode([LikePhoto].self, from: data)
                {
                    handler(decoder)
                    print("test1")
                }
            }
        }.resume()
    }
    
    //刪除我的最愛
    func deletedMyLike(outLikePhoto inLikePhoto:LikePhoto ,handler:@escaping (Int)-> Void)  {
        var url = URL(string: "https://sheetdb.io/api/v1/q5xzqpddkdsmm/id/\(inLikePhoto.id)")
        var req = URLRequest(url: url!)
        req.httpMethod = "DELETE"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try? JSONEncoder().encode(inLikePhoto.id)
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let error = error{
                print("error:\(error)")
            }else if let response = response, let data = data{
                print("response:\(response)")
                let decoder = try? JSONDecoder().decode([String:Int].self, from: data)
                if decoder?["deleted"] == 1{
                    handler(1)
                }else{
                    handler(0)
                }
            }
        }.resume()
        
    }
    
}

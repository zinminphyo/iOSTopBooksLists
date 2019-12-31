//
//  AudioBook.swift
//  iOSTopBooksLists
//
//  Created by Zin Min Phyoe on 12/30/19.
//  Copyright © 2019 Zin Min Phyoe. All rights reserved.
//

import Foundation

struct  AudioBook {
    let name : String
    let author : String
    let coverImage : String
    
    init(dictionary: [String:Any]){
        self.name = dictionary["name"]! as! String
        self.author = dictionary["artistName"]! as! String
        self.coverImage = dictionary["artworkUrl100"]! as! String
    }
}

struct APIClient {
    static var urlString : String = Constants.BOOK_API_LINK
    static func getAudioBooksApi(completion: @escaping ([String:Any]?) -> Void){
        let  url = URL(string: urlString)
        let session = URLSession.shared
        guard let unwrappedURL = url else {  print("Error unwrapping urls.");  return }
        let dataTask = session.dataTask(with: unwrappedURL) { (data, response, error) in
            guard let unwrappedData = data else {print("Error unwrapping data."); return}
            do{
                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String:Any]
                completion(responseJSON)
            }catch {
                print("Could not get api data. \(error), \(error.localizedDescription) ")
            }
        }
        dataTask.resume()

    }
}

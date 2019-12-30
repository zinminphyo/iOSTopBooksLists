//
//  DataStore.swift
//  iOSTopBooksLists
//
//  Created by Zin Min Phyoe on 12/30/19.
//  Copyright © 2019 Zin Min Phyoe. All rights reserved.
//

import Foundation
import UIKit

final class DataStore {
    static let shareInstance = DataStore()
    fileprivate init(){}
    var audioBooks:[AudioBook] = []
    var images:[UIImage]=[]
    
    func getBooks(completion : @escaping () -> Void){
        APIClient.getAudioBooksApi{ (json) in
            let feed = json!["feed"] as? [String:Any]
            let results = feed!["results"] as? [[String:Any]]
            for dict in results! {
               let newBook = AudioBook(dictionary: dict)
                self.audioBooks.append(newBook)
             }
            completion()
            }
    }
    
    func getBookImages(completion : @escaping() -> Void){
        getBooks {
            for book in self.audioBooks {
                let url = URL(string: book.coverImage)
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.images.append(image!)
                }
            }
            OperationQueue.main.addOperation {
                completion()
            }
        }
    }
    
}

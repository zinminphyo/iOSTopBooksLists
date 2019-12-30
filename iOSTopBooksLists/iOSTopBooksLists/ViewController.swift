//
//  ViewController.swift
//  iOSTopBooksLists
//
//  Created by Zin Min Phyoe on 12/30/19.
//  Copyright © 2019 Zin Min Phyoe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBar: UITabBar!
    
    let dataStore = DataStore.shareInstance
    var selectCell : ItemCollectionViewCell?
    
    override func viewDidLoad() {
           super.viewDidLoad()
            dataStore.getBookImages {
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
       }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataStore.audioBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ITEM_IDENTIFIER, for: indexPath) as! ItemCollectionViewCell
        let selectedItem = dataStore.audioBooks[indexPath.row]
        item.displayEachItem(image: dataStore.images[indexPath.row], title: selectedItem.name)
        return item
    }
   


}


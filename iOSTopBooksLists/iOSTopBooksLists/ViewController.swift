//
//  ViewController.swift
//  iOSTopBooksLists
//
//  Created by Zin Min Phyoe on 12/30/19.
//  Copyright © 2019 Zin Min Phyoe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITabBarDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var reloadingIndicator: UIActivityIndicatorView!
    
    let dataStore = DataStore.shareInstance
    var selectCell : ItemCollectionViewCell?
    
    override func viewDidLoad() {
           super.viewDidLoad()
        reloadingIndicator.isHidden = false
        reloadingIndicator.startAnimating()
        loadinIndicatorPosition()
        dataStore.getBookImages {
             self.collectionView.reloadSections(IndexSet(integer: 0))
            }
        tabBar.items?.append(UITabBarItem(title: "Music Video", image: UIImage(named: "video"), selectedImage: nil))
        tabBar.items?.append(UITabBarItem(title: "Movie", image: UIImage(named: "playbutton"), selectedImage: nil))
        tabBar.items?.append(UITabBarItem(title: "Apps", image: UIImage(named: "mobile"), selectedImage: nil))
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
   
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        reloadingIndicator.isHidden = false
        reloadingIndicator.startAnimating()
        dataStore.audioBooks.removeAll()
        collectionView.isHidden = true
        dataStore.images.removeAll()
        switch item.title {
        case "Music Video":
            APIClient.urlString = Constants.MUSIC_VIDEO_API_LINK
        case "Movie":
            APIClient.urlString = Constants.MOVIE_API_LINK
        case "Apps":
            APIClient.urlString = Constants.APP_API_LINK
        case "Music":
            APIClient.urlString = Constants.MUSIC_API_LINK
        default:
            APIClient.urlString = Constants.BOOK_API_LINK
        }
       dataStore.getBookImages {
        self.collectionView.reloadData()
        self.reloadingIndicator.stopAnimating()
        self.reloadingIndicator.isHidden = true
        self.collectionView.isHidden = false
        self.collectionView.reloadSections(IndexSet(integer: 0))
       }
    }
    
    func loadinIndicatorPosition() {
        reloadingIndicator.isHidden = true
        reloadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(reloadingIndicator)

        // Auto layout
        let horizontalConstraint = NSLayoutConstraint(item: reloadingIndicator as Any,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: self.view,
                                                      attribute: .centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: reloadingIndicator as Any,
                                                    attribute: .centerY,
                                                    relatedBy: .equal,
                                                    toItem: self.view,
                                                    attribute: .centerY,
                                                    multiplier: 1,
                                                    constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
    }

}


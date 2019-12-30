//
//  ItemCollectionViewCell.swift
//  iOSTopBooksLists
//
//  Created by Zin Min Phyoe on 12/31/19.
//  Copyright © 2019 Zin Min Phyoe. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bookLabel : UILabel!
    @IBOutlet weak var bookImage : UIImageView!
    
    func displayEachItem(image:UIImage,title:String){
        self.bookImage.image = image
        self.bookLabel.text = title
    }
    
}

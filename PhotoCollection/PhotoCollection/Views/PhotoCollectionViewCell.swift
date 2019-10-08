//
//  PhotoCollectionViewCell.swift
//  PhotoCollection
//
//  Created by Spencer Curtis on 8/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    var photo: Photo? {
        didSet {
            
        }
    }
    
    private var imageView: UIImageView!
    private var nameLabel: UILabel!
    
    
    
    
    func setUpSubViews() {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
//    call the subview
        addSubview(imageView)
        
//         turn off the auto layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: imageView,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: 4),
            NSLayoutConstraint(item: imageView,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .leading,
                               multiplier: 1,
                               constant: 4),
            NSLayoutConstraint(item: imageView,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: -2),
            NSLayoutConstraint(item: imageView,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .width,
                               multiplier: 1,
                               constant: 0)
        ])
        self.imageView = imageView
        
        let label = UILabel()
        label.textAlignment = .center
        
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: label,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: imageView,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 4),
            NSLayoutConstraint(item: label,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: imageView,
                               attribute: .leading,
                               multiplier: 1,
                               constant: 2),
            NSLayoutConstraint(item: label,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: imageView,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: -2)
        ])
        self.nameLabel = label
        
    }
    
//    returning the UIImage data of the photo
     func updateViews() {
        imageView.image = UIImage(data: (photo?.imageData ?? nil)!)
        nameLabel.text = photo?.title
    }
    
    
}

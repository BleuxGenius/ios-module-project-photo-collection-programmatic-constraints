//
//  PhotoCollectionViewController.swift
//  PhotoCollection
//
//  Created by Dani on 8/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

// implement the delegation flow protocol
class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let photoController = PhotoController()
    let themeHelper = ThemeHelper()
    
//     implement how many images on each row with be showing
    var horizontalItems: CGFloat = 2
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.reloadData()
        setTheme()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoController.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        let photo = photoController.photos[indexPath.row]
        
        cell.photo = photo
        
        return cell
    }
//    implemnt section layout for collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets()
    }
//     implement cell spacing method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return(0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLAyout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontralInsets = collectionView.contentInset.left +
            collectionView.contentInset.right
        let itemSpacing = (collectionViewLayout as!
            UICollectionViewFlowLayout).minimumLineSpacing *
            (horizontalItems - 1)
        let width = (collectionView.frame.width - horizontralInsets - itemSpacing) / horizontalItems
        return CGSize(width: width, height:  width * 1.2)
    }
//    MARK: - Private Method
    private func setTheme() {
    
        guard let themePreference = themeHelper.themePreference else { return }
        
        var backgroundColor: UIColor!
        
        switch themePreference {
        case "Dark":
            backgroundColor = .lightGray
        case "Blue":
            backgroundColor = UIColor(red: 61/255, green: 172/255, blue: 247/255, alpha: 1)
        default:
            break
        }
        
        collectionView?.backgroundColor = backgroundColor
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case "SelectTheme":
            
            guard let destinationVC = segue.destination as? ThemeSelectionViewController else { return }
            
            destinationVC.themeHelper = themeHelper
            
        case "CreatePhoto":
            
            guard let destinationVC = segue.destination as? PhotoDetailViewController else { return }
            
            destinationVC.photoController = photoController
            destinationVC.themeHelper = themeHelper
            
        case "ViewPhoto":
            
            guard let destinationVC = segue.destination as? PhotoDetailViewController,
                let indexPath = collectionView?.indexPathsForSelectedItems?.first else { return }
            
            destinationVC.photo = photoController.photos[indexPath.row]
            destinationVC.photoController = photoController
            destinationVC.themeHelper = themeHelper
            
        default:
            break
        }
    }
}

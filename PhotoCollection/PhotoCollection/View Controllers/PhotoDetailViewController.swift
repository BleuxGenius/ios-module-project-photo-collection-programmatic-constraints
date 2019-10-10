//
//  PhotoDetailViewController.swift
//  PhotoCollection
//
//  Created by Dani on 8/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import Photos

class PhotoDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    MARK: - PROPERTIES
    
    var imageView: UIImageView!
    var titleTextField: UITextField!
    
//    update the view
    var photo: Photo? {
        didSet {
            if isViewLoaded{
                updateViews()
            }
        }
    }
    
    var photoController: PhotoController?
    var themeHelper: ThemeHelper?
    
//    update the view
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
//        setTheme()
//        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTheme()
        updateViews()
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        imageView.image = image
    }
    
    // MARK: - Private Methods
    
    func setUpSubViews() {
//         add UIImageView to viewController
        let imageView = UIImageView()
//        add subview
        view.addSubview(imageView)
//        turn auto restraints with the storeboard
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
//        MARK: - OUTLETS
//        create outlets
//        addButton to viewController. Buttons are usually type system to abide by basic ios rules
        let button = UIButton(type: .system)
//         set title of button
        button.setTitle("Add Image", for: .normal)
        button.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
//        create outlets
        let textField = UITextField()
        textField.placeholder = "Give this photo a title"
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
    
//    MARK: Programmactically Contrained
        
    NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 10),
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
        button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
        button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        textField.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
        textField.centerXAnchor.constraint(equalTo:view.safeAreaLayoutGuide.centerXAnchor),
        textField.widthAnchor.constraint(equalTo: imageView.widthAnchor)
    ])
//        create uibarbutton
        
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = "Save Photo"
        barButtonItem.target = self
        barButtonItem.action = #selector(savePhoto)
        
        navigationItem.setRightBarButton(barButtonItem, animated: true)

        self.imageView = imageView
        self.titleTextField = textField
        
    }
//    MARK: - METHODS
    @objc private func addImage() {
            
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
    
        switch authorizationStatus {
        case .authorized:
            presentImagePickerController()
            
        case .notDetermined:
            
            PHPhotoLibrary.requestAuthorization { (status) in
                
                guard status == .authorized else {
                    NSLog("User did not authorize access to the photo library")
                    return
                }
                self.presentImagePickerController()
            }
        default:
            break
        }
    }
//    MARK: - PRIVATE FUNCTIONS 
    @objc private func savePhoto() {
        
        guard let image = imageView.image,
            let imageData = image.pngData(),
            let title = titleTextField.text else { return }
        
        if let photo = photo {
            photoController?.update(photo: photo, with: imageData, and: title)
        } else {
            photoController?.createPhoto(with: imageData, title: title)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        
        guard let photo = photo else {
            title = "Create Photo"
            return
        }
        
        title = photo.title
        
        imageView.image = UIImage(data: photo.imageData)
        titleTextField.text = photo.title
    }
    
    private func presentImagePickerController() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func setTheme() {
        guard let themePreference = themeHelper?.themePreference else { return }
        
        var backgroundColor: UIColor!
        
        switch themePreference {
        case "Dark":
            backgroundColor = .lightGray
        case "Blue":
            backgroundColor = UIColor(red: 61/255, green: 172/255, blue: 247/255, alpha: 1)
        default:
            break
        }
        
        view.backgroundColor = backgroundColor
    }
}

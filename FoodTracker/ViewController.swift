//
//  ViewController.swift
//  FoodTracker
//
//  Created by  Kerensa E Mattison on 2018-02-02.
//  Copyright © 2018  Kerensa E Mattison. All rights reserved.
//

import UIKit
import os

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    
    var item: FoodItem?
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var expiryDate: UIDatePicker!
    @IBOutlet weak var expiryIndicator: ExpiryIndicator!
    // MARK: Delegate Methods

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.expiryDate.addTarget(self, action: #selector(dateChanged(_:)),
        for: .valueChanged)
    }
    @objc func dateChanged(_ sender: UIDatePicker) {
expiryIndicator.expiry(date: sender.date)
        //call the expiry indicator (selected date)
        //debugPrint(sender.date)
    }
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated:true, completion:nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage else {
                os_log("Missing image in %@", log: OSLog.default, type: .debug, info)
                return
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        
        item = FoodItem(image: photoImageView.image ?? #imageLiteral(resourceName: "defaultImage"), expiryDate: expiryDate.date)
    }
    // MARK: Actions

}


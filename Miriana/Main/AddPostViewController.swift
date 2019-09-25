//
//  AddPostViewController.swift
//  Miriana
//
//  Created by Alumno on 9/25/19.
//  Copyright © 2019 Sector Defectuoso. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var ivPreview: CSMImageView!
    let imgPicker = UIImagePickerController()
    
    
    @IBAction func btnAddImage(_ sender: Any) {
        imgPicker.allowsEditing = false
        imgPicker.sourceType = .photoLibrary
        
        present(imgPicker, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgPicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            ivPreview.contentMode = .scaleAspectFit
            ivPreview.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    

}

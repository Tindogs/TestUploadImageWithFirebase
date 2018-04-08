//
//  ViewController.swift
//  TestFirebase
//
//  Created by Fabio Gomez on 3/4/18.
//  Copyright © 2018 Fabio Gomez. All rights reserved.
//

import UIKit
import FirebaseStorage

class ViewController: UIViewController {

    let filename = "sirena.jpg"
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var downloadImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onUploadTapped(_ sender: Any) {
        guard let image = uploadImage.image else { return }
        guard let imageData = UIImageJPEGRepresentation(image, 1) else { return }
        
        let uploadImageRef = imageReference.child(filename)
        
        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if error == nil {
                print(metadata!)
            } else {
                print("💩 \(error!)")
            }
            
        }
        
        uploadTask.resume()
    }
    
    @IBAction func onDownloadTapped(_ sender: Any) {
        let downloadImageRef = imageReference.child(filename)
        
        let downloadtask = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
            
            if error != nil {
                print("💩 \(error!)")
            }
            
            if let data = data {
                let image = UIImage(data: data)
                self.downloadImage.image = image
            }
        }
        
        downloadtask.resume()
    }
}


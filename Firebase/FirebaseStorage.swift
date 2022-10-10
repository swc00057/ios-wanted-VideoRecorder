//
//  uploadVideo.swift
//  VideoRecorder
//
//  Created by 신동원 on 2022/10/11.
//

import UIKit
import FirebaseStorage

class FirebaseStorage {
    static let shared = FirebaseStorage()
    let storage = Storage.storage()
    
    //TEST CODE
    func upload() {
        // Create a root reference
        let storageRef = storage.reference()
        
        // Create a reference to 'images/테스트이미지.jpg'
        let testImagesRef = storageRef.child("images/테스트이미지.jpg")
        
        // Data in memory
        var data = Data()
        data = UIImage(named: "01")!.jpegData(compressionQuality: 1)!
        
        // Upload the file to the path "images/테스트이미지.jpg"
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        testImagesRef.putData(data, metadata: metadata) { (metadata, error) in
            print(error)
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            print(metadata)
            // You can also access to download URL after upload.
            testImagesRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                print(downloadURL)
            }
        }
    }
}

//
//  StorageManager.swift
//  Dota2Dictionary
//
//  Created by MacOS on 21/11/2021.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    /*
     /images/giang113-gmail-com_profile_picture_png
     */
    
    typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    /// upload picture to firebase storage and return completion with url string to download
    public func uploadProfilePicture(with data: Data,
                                     fileName: String,
                                     completion: @escaping UploadPictureCompletion) {
        storage
            .child("images/\(fileName)")
            .putData(data,
                     metadata: nil,
                     completion: { (_, error) in
                        guard error == nil else {
                            print("failed upload data to firebase for avatar")
                            completion(.failure(StorageError.failedToUpload))
                            return
                        }
                        
                        self.storage
                            .child("images/\(fileName)")
                            .downloadURL(completion: { (url, error) in
                                guard error == nil else {
                                    print("failed to get download url for avatar")
                                    completion(.failure(StorageError.failedToGetDownloadUrl))
                                    return
                                }
                                
                                if let urlString = url?.absoluteString {
                                    print("download url return \(urlString)")
                                    completion(.success(urlString))
                                }
                        })
            })
    }
    
    public enum StorageError: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    }
}

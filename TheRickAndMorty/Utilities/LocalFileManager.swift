//
//  FileManager.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 07.09.2023.
//

import Foundation
import SwiftUI



class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    let folderName: String = "rick_and_morty_images"
    
    private init() {
        creatFolderAtFirstLaunch()
    }
    
    func creatFolderAtFirstLaunch() {
        
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appending(path: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: path.path()) {
            do {
              try  FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
                print("Directory created")
                print(path.path())
            } catch let error {
                print("Error of creating directory: \(error)")
            }
        }
    }
    
    func saveImageToFileManager(for name: String, for image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 1.0),
        let path = pathForImage(for: name) else { return }
        
        do {
           try data.write(to: path)
            print("Image saved")
        } catch let error {
            print("Error of saving image: \(error)")
        }
    }
    
    func deleteImage(for name: String) {
        guard let path = pathForImage(for: name),
        FileManager.default.fileExists(atPath: path.path())
        else { return }
        do {
           try FileManager.default.removeItem(at: path)
            print("Image deleted")
        } catch let error {
            print("Error of removing image: \(error)")
        }
    }
    
    func getImageFromFileManager(for name: String) -> UIImage? {
        guard let path = pathForImage(for: name),
              FileManager.default.fileExists(atPath: path.path()) else {
            return nil
        }
        
        return UIImage(contentsOfFile: path.path())
    }
    
    func pathForImage(for name: String) -> URL? {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appending(path: folderName).appending(path: name) else {
            print("error of geting path")
            return nil }
         return path
    }
}

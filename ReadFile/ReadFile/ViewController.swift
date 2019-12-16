//
//  ViewController.swift
//  ReadFile
//
//  Created by iMac_VTCA on 12/13/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

//File manager in swift = Finder on Mac
//File handle in swift = Reading Application on Mac (Word, Pdf reader,...)

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let fileManager = FileManager.default
        let currentPath = fileManager.currentDirectoryPath
        
        print("currentPath: \(currentPath)")
        
        let dirPaths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        //Create docs dir path
        guard let docsDir = dirPaths.first?.path else { return }
        print(docsDir)
        
        //Create temp dir
        let _ = NSTemporaryDirectory()
        
        if fileManager.changeCurrentDirectoryPath(docsDir) {
            print("Change dir success")
        } else {
            print("Change dir false")
        }
        
        let anotherDir = "\(docsDir)/abc"
        
        if fileManager.changeCurrentDirectoryPath(anotherDir) {
            print("Change dir success")
        } else {
            print("Change dir false")
        }
        
        //Create a new folder in user domain
        
        let newDir = dirPaths[0].appendingPathComponent("data/Vinh").path
        
        do {
            try fileManager.createDirectory(atPath: newDir, withIntermediateDirectories: true, attributes: nil)
            //withIntermediateDirectories == true => example: Documents/data/Vinh, if folder data is not exist will create folder data then create folder Vinh
            
            //withIntermediateDirectories == false => example: Documents/data/Vinh, if folder data is not exist will cancel
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            try fileManager.removeItem(atPath: newDir)
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            //let fileList = try fileManager.contentsOfDirectory(atPath: "/Users/imac_vtca/Desktop/MD11/Bai-tap-iOS")
            let fileList = try fileManager.contentsOfDirectory(atPath: "/")
            
            for fileName in fileList {
                print(fileName)
            }
            
        } catch let err {
            print(err.localizedDescription)
        }
        
        
        //Get type/ attribute of folder
        
        do {
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            print("dirPath: \(dirPath)")
            
            let attributes = try fileManager.attributesOfItem(atPath: "\(dirPath)/data")
            let type = attributes[FileAttributeKey.type] as! String
            print(type)
            
        } catch let err {
            print(err.localizedDescription)
        }
        
        //File exist?
        if fileManager.fileExists(atPath: "/Applications") {
            print("File exists")
        } else {
            print("File not found")
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Compare file:
        
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
        print("path: -- \(path)")
        
        let url = NSURL(fileURLWithPath: path)
        let fileManager = FileManager.default
        
        guard let pathComponent1 = url.appendingPathComponent("test1.txt"), let pathComponent2 = url.appendingPathComponent("test2.txt") else { return }
        let filePath1 = pathComponent1.path
        let filePath2 = pathComponent2.path
        
        let isEqual = fileManager.contentsEqual(atPath: filePath1, andPath: filePath2)
        
        if isEqual {
            print("test1.txt is equal to test2.txt")
        } else {
            print("test1.txt is not equal to test2.txt")
        }
        
        if fileManager.isReadableFile(atPath: filePath1) {
            print("filePath1 is readable")
        }
        if fileManager.isWritableFile(atPath: filePath1) {
            print("filePath1 is writable")
        }
        if fileManager.isDeletableFile(atPath: filePath1) {
            print("filePath1 is Deletable")
        }
        if fileManager.isExecutableFile(atPath: filePath1) {
            print("filePath1 is ExecutableFile")
        }
        
        
        //Move Items:
        
        let dirPaths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        //Create docs directory
        guard let docsDir = dirPaths.first?.path else { return }
        
        let destinationPath = "\(docsDir)/data"
        
        if fileManager.isWritableFile(atPath: destinationPath) {
            print("destinationPath isWritableFile")
        }
        
        do {
            
            //            try fileManager.moveItem(atPath: filePath2, toPath: "\(destinationPath)/test2.txt")
            
            try fileManager.copyItem(atPath: filePath2, toPath: "\(destinationPath)/test2.txt")
            
            //            try fileManager.removeItem(atPath: "\(destinationPath)/test2.txt")
            
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Create file:
        
        let fileManager = FileManager.default
//        let strDataToWrite = "Hello world".data(using: .utf8)
//
//        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
//
//        if let safePath = path {
//            if let documentPath = NSURL(fileURLWithPath: safePath).appendingPathComponent("text.txt")?.path {
//                let isCreateSuccess = fileManager.createFile(atPath: documentPath, contents: strDataToWrite, attributes: nil)
//                if isCreateSuccess {
//                    print("Create file success!!")
//                }
//            }
//        }
        
        //Read file:
        
        let fileURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let filePath = fileURL?.appendingPathComponent("text.txt").path
        
        guard let safeFilePath = filePath else { return }
        
        do {
            let data = try String(contentsOfFile: safeFilePath, encoding: .utf8)
            //            let data = try String(contentsOfFile: safeFilePath)
            
            print("data: \(data)")
        } catch  {
            print("Error: \(error)")
        }
        
        //Read file 2:
        
        //Create a file handle (open file handle then close file handle)
        let fileHandle: FileHandle? = FileHandle(forReadingAtPath: safeFilePath)
        
        guard let safeFileHandle = fileHandle else { print("Open file failed"); return }
        
        safeFileHandle.seek(toFileOffset: 5)
        if let dataBuffer = fileHandle?.readData(ofLength: 100) {
            print("==========================")
            print("dataBuffer: \(dataBuffer)")
            
            if let str = String(data: dataBuffer, encoding: .utf8) {
                print("str: \(str)")
            }
            
            fileHandle?.closeFile()
        }
        
//        if let dataBuffer = file?.readDataToEndOfFile() {
//            print("==========================")
//            print("dataBuffer: \(dataBuffer)")
//
//            if let str = String(data: dataBuffer, encoding: .utf8) {
//                print("str: \(str)")
//            }
//
//            file?.closeFile()
//        }
        
        //Write file:
        
        let fileHandleForUpdating: FileHandle? = FileHandle(forUpdatingAtPath: safeFilePath)
        
        if fileHandleForUpdating != nil {
            if let data = (" I'm Vinh").data(using: .utf8) {
//                fileHandleForUpdating!.seek(toFileOffset: 10)
                fileHandleForUpdating?.seekToEndOfFile()
                fileHandleForUpdating!.write(data)
                fileHandleForUpdating!.closeFile()
            }
        }
    }
}


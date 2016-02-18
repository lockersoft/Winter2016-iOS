//
//  FileUtils.swift
//  Lecture Winter 2016
//
//  Created by Jones, Dave on 1/20/16.
//  Copyright © 2016 Jones, Dave. All rights reserved.
//

import Foundation

class FileUtils {
    
    var fileName = ""
    var defaultDirectory : NSURL
    var pathUrl : NSURL
    var fileMgr : NSFileManager
    
    init( fileName : String ){
        self.fileName = fileName
        fileMgr = NSFileManager.defaultManager()
        defaultDirectory = try! fileMgr.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        
        pathUrl = defaultDirectory.URLByAppendingPathComponent(fileName )
        print( pathUrl.path )
    }
    
    func clearFile() {
        do {
            let file : NSFileHandle? = try NSFileHandle(forWritingToURL: pathUrl )
            file?.truncateFileAtOffset(0)
            file?.closeFile()
        } catch let error as NSError {
            print( "File error in clearFile: \(error)")
        }
    }
    
    func createFile( outputData : String ) {
        fileMgr.createFileAtPath(pathUrl.path!, contents: outputData.dataUsingEncoding(NSUTF8StringEncoding)!, attributes: nil )
    }
    
    func fileExists() -> Bool {
        return fileMgr.fileExistsAtPath(pathUrl.path!)
    }
    
    func appendFile( outputData : String ) -> Bool {
        var retVal = false
        if( !fileExists() ) {
            createFile( outputData )
        }
        do {
            let file : NSFileHandle? = try NSFileHandle(forWritingToURL: pathUrl )
            file?.seekToEndOfFile()
            file?.writeData(outputData.dataUsingEncoding(NSUTF8StringEncoding)! )
            file?.closeFile()
            retVal = true
        } catch let error as NSError {
            print( "File Error in appending: \(error)" )
        }
        
        return retVal
    }
    
    func readFile() -> String {
        var retStr = ""
        
        let content = NSData( contentsOfURL: pathUrl )
        let dataString = String(data: content!, encoding: NSUTF8StringEncoding )
        if let c = dataString {
            retStr = c
        }
        return retStr
    }
    
    func writeFile ( data : String ) -> Bool {
        var retVal = false
        
        do {
            try data.writeToURL(pathUrl, atomically: true, encoding: NSUTF8StringEncoding )
            retVal = true       // Successful write
        } catch let error as NSError {
            print("Error: \(error)")
        }
        return retVal
    }
}
//
//  FileHandler.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/10/22.
//

import Foundation
import SwiftUI


class FileHandler {
    
    let DEFAULTDIRECTORYPATH = "/Bluetooth Multimeter"
    let fileManager: FileManager
    
    init() {
        
        fileManager = FileManager()
        //fileManager.changeCurrentDirectoryPath(FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: , create: <#T##Bool#>))
    }
    
    func temporaryDataFile(fileName: String, data: Date) -> Void {
        let path = FileManager
            .default
            .temporaryDirectory
            .appendingPathComponent("\(fileName).chart")
        
    }
}

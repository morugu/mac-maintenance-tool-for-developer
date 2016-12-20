//
//  Command.swift
//  DCleanUp
//
//  Created by shoya on 2016/11/23.
//  Copyright © 2016 Shoya Shiraki. All rights reserved.
//

import Cocoa


class Command {
    func execute(type: CommandType) -> Int {
        if let path = Bundle.main.path(forResource: type.scriptFileName, ofType:"scpt") {
            let task = Process()
            NotificationCenter.default.addObserver(self, selector: #selector(readComplete), name: NSNotification.Name.NSFileHandleReadToEndOfFileCompletion, object: nil)
            
            task.launchPath = "/usr/bin/osascript"
            task.arguments = [path]
            
            let pipe = Pipe()
            
            pipe.fileHandleForReading.readToEndOfFileInBackgroundAndNotify()
            task.standardOutput = pipe
            task.launch()
            task.waitUntilExit()
            
            
            let handle = pipe.fileHandleForReading
            let data = handle.readDataToEndOfFile()
            if let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                print(result)
            }
            
            return Int(task.terminationStatus)
        }
        return 1
    }
    
    @objc func readComplete(notification: Notification) {
        print(notification)
        print(notification.object)
        let handler = notification.object as! FileHandle
        NotificationCenter.default.removeObserver(self, name: Notification.Name.NSFileHandleReadToEndOfFileCompletion, object: nil)
    }
}

protocol CommandExtention {
    var script: String { get }
    var scriptFileName: String { get }
    var scriptTitle: String { get }
}

enum CommandType: CommandExtention {
    
    case Purge,
    UpdateDyldSharedCache,
    UpdateKernelCache,
    DeleteArchives,
    DeleteCaches,
    DeleteDerivedData,
    PurgeKernelExtensionCache,
    LL
    
    
    static let allValues = [Purge, UpdateDyldSharedCache, UpdateKernelCache, DeleteArchives, DeleteCaches, DeleteDerivedData, PurgeKernelExtensionCache, LL]
    
    var script: String {
        switch self {
        case .Purge: return "sudo purge"
        case .UpdateDyldSharedCache: return "sudo update_dyld_shared_cache -force"
        case .UpdateKernelCache: return "sudo kextcache -system-prelinked-kernel"
        case .PurgeKernelExtensionCache: return "sudo kextcache -system-caches"
        case .DeleteArchives: return "sudo rm -rf ~/Library/Developer/Xcode/Archives"
        case .DeleteCaches: return "sudo rm -rf ~/Library/Caches"
        case .DeleteDerivedData: return "sudo rm -rf ~/Library/Developer/Xcode/DerivedData"
        case .LL: return "LL"
        }
    }

    var scriptFileName: String {
        switch self {
        case .Purge: return "Purge"
        case .UpdateDyldSharedCache: return "UpdateDyldSharedCache"
        case .UpdateKernelCache: return "UpdateKernelCache"
        case .PurgeKernelExtensionCache: return "PurgeKernelExtensionCache"
        case .DeleteArchives: return "DeleteArchives"
        case .DeleteCaches: return "DeleteCaches"
        case .DeleteDerivedData: return "DeleteDerivedData"
        case .LL: return "LL"
        }
    }
    
    var scriptTitle: String {
        switch self {
        case .Purge: return NSLocalizedString("Purge", comment: "")
        case .UpdateDyldSharedCache: return NSLocalizedString("UpdateDyldSharedCache", comment: "")
        case .UpdateKernelCache: return NSLocalizedString("UpdateKernelCache", comment: "")
        case .PurgeKernelExtensionCache: return NSLocalizedString("PurgeKernelExtensionCache", comment: "")
        case .DeleteArchives: return NSLocalizedString("DeleteArchives", comment: "")
        case .DeleteCaches: return NSLocalizedString("DeleteCaches", comment: "")
        case .DeleteDerivedData: return NSLocalizedString("DeleteDerivedData", comment: "")
        case .LL: return "LL"
        }
    }
}

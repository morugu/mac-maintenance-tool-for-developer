//
//  Command.swift
//  DCleanUp
//
//  Created by shoya on 2016/11/23.
//  Copyright © 2016 Shoya Shiraki. All rights reserved.
//

import Cocoa


class Command {
    static func execute(type: CommandType) -> Int {
        if let path = Bundle.main.path(forResource: type.scriptFileName, ofType:"scpt") {
            let task = Process()
            task.launchPath = "/usr/bin/osascript"
            task.arguments = [path]
            task.launch()
            task.waitUntilExit()
            return Int(task.terminationStatus)
        }
        return 1
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
    PurgeKernelExtensionCache
    
    static let allValues = [Purge, UpdateDyldSharedCache, UpdateKernelCache, DeleteArchives, DeleteCaches, DeleteDerivedData, PurgeKernelExtensionCache]
    
    var script: String {
        switch self {
        case .Purge: return "sudo purge"
        case .UpdateDyldSharedCache: return "sudo update_dyld_shared_cache -force"
        case .UpdateKernelCache: return "sudo kextcache -system-prelinked-kernel"
        case .PurgeKernelExtensionCache: return "sudo kextcache -system-caches"
        case .DeleteArchives: return "sudo rm -rf ~/Library/Developer/Xcode/Archives"
        case .DeleteCaches: return "sudo rm -rf ~/Library/Caches"
        case .DeleteDerivedData: return "sudo rm -rf ~/Library/Developer/Xcode/DerivedData"
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
        }
    }
}

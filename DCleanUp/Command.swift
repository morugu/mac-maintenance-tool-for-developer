//
//  Command.swift
//  DCleanUp
//
//  Created by shoya on 2016/11/23.
//  Copyright © 2016 Shoya Shiraki. All rights reserved.
//

import Cocoa

protocol CommandExtention {
    var path: String { get }
    var directoryPath: String { get }
    var scriptFileName: String { get }
}

enum CommandType: CommandExtention  {
    case CheckDiskVolume, Purge, UpdateDyldSharedCache
    
    var path: String {
        switch self {
        case .CheckDiskVolume: return "~/"
        case .Purge: return "~/"
        case .UpdateDyldSharedCache: return "~/"
        }
    }
    
    var directoryPath: String {
        switch self {
        case .CheckDiskVolume: return "~/"
        case .Purge: return "~/"
        case .UpdateDyldSharedCache: return "~/"
        }
    }
    
    var scriptFileName: String {
        switch self {
        case .CheckDiskVolume: return "CheckDiskVolume"
        case .Purge: return "Purge"
        case .UpdateDyldSharedCache: return "UpdateDyldSharedCache"
        }
    }
    
    
//    case
//    Env = "/usr/bin/env",
//    Purge = "/usr/sbin/purge",
//    DeleteDerivedData = " rm -rf ~/Library/Developer/Xcode/DerivedData",
//    DeleteArchives = "rm -rf ~/Library/Developer/Xcode/Archives",
//    DeleteCaches = "rm -rf ~/Library/Caches",
//    Ls = "/bin/ls"
}

class Command {
    
    static let BasePath = "/usr/bin/"
    
    static func execute(type: CommandType) -> Int {
//        print(type.rawValue)
        
//         TODO: http://stackoverflow.com/questions/26707557/how-to-execute-a-shell-command-with-root-permission-from-swift
//        let script = "do shell script \"\(type.rawValue)\" with administrator privileges";
//        NSAppleScript(source: script)!.executeAndReturnError(nil)
//        print(script)
        if let path = Bundle.main.path(forResource: type.scriptFileName, ofType:"scpt") {
            let task = Process()
            task.launchPath = "/usr/bin/osascript"
            task.currentDirectoryPath = type.directoryPath
            task.arguments = [path]
            task.launch()
        }
        
//        let task = Process()
//        task.launchPath = type.rawValue
//        task.currentDirectoryPath = "~/Desktop/SpotifyTimer 2016-11-13 16-38-52"
//        task.launch()
//        task.waitUntilExit()
//        return Int(task.terminationStatus)
        return 0
    }
}

//
//  Command.swift
//  DCleanUp
//
//  Created by shoya on 2016/11/23.
//  Copyright © 2016 Shoya Shiraki. All rights reserved.
//

import Cocoa

enum CommandType: String {
    case
    Env = "/usr/bin/env",
    Purge = "/usr/sbin/purge"
}

class Command {
    
    static let BasePath = "/usr/bin/"
    
    static func execute(type: CommandType) -> Int {
        print(type.rawValue)
        
        // TODO: http://stackoverflow.com/questions/26707557/how-to-execute-a-shell-command-with-root-permission-from-swift
        NSAppleScript(source: "do shell script \"sudo \(type.rawValue)\" with administrator " +
            "privileges")!.executeAndReturnError(nil)
        
        let task = Process()
//        task.launchPath = type.rawValue
//        task.launch()
//        task.waitUntilExit()
        return Int(task.terminationStatus)
    }
}

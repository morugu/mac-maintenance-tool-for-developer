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
    Env = "env"
}

class Command {
    
    static let BasePath = "/usr/bin/"
    
    static func execute(type: CommandType) -> Int {
        print(type.rawValue)
        
        let task = Process()
        task.launchPath = BasePath + type.rawValue
        task.launch()
        task.waitUntilExit()
        return Int(task.terminationStatus)
    }
}

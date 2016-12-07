//
//  AlertView.swift
//  DCleanUp
//
//  Created by shoya on 2016/12/08.
//  Copyright © 2016 Shoya Shiraki. All rights reserved.
//

import Cocoa

class AlertView: NSAlert {
    
    override init() {
        super.init()
        addButton(withTitle: "OK")
        addButton(withTitle: "Cancel")
        alertStyle = .informational
        messageText = "Are you sure you want to execute following command?"
    }
}

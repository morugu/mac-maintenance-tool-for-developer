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
        addButton(withTitle: NSLocalizedString("ALERT_OK", comment: "ok"))
        addButton(withTitle: NSLocalizedString("ALERT_CANCEL", comment: "cancel"))
        alertStyle = .informational
        messageText = NSLocalizedString("CONFIRM_MESSAGE", comment: "confirm message")
    }
}

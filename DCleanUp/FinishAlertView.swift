//
//  FinishAlertView.swift
//  DCleanUp
//
//  Created by shoya on 2016/12/11.
//  Copyright © 2016 Shoya Shiraki. All rights reserved.
//

import Cocoa

class FinishAlertView: NSAlert {
    override init() {
        super.init()
        addButton(withTitle: NSLocalizedString("ALERT_CLOSE", comment: "ok"))
        alertStyle = .informational
        messageText = NSLocalizedString("FINISH_MESSAGE", comment: "finish message")
    }
}

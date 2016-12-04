//
//  ViewController.swift
//  DCleanUp
//
//  Created by shoya on 2016/11/18.
//  Copyright © 2016 Shoya Shiraki. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var commandLabel: NSTextField!
    @IBOutlet weak var commandSelectButton: NSPopUpButton!
    @IBOutlet weak var executeCommandButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultSelectCommandsTitle()
    }
    
    func setDefaultSelectCommandsTitle() {
        commandSelectButton.removeAllItems()
        for value in CommandType.allValues {
            commandSelectButton.addItem(withTitle: value.scriptFileName)
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}


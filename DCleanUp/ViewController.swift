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
        setup()
    }
    
    func setup() {
        setDefaultSelectCommandsTitle()
        setLabelText()
        commandSelectButton.action = #selector(setLabelText)
        executeCommandButton.action = #selector(tapExecuteButton)
        executeCommandButton.title = NSLocalizedString("EXECUTE", comment: "execute")
    }
    
    override func viewWillAppear() {
        self.view.layer?.backgroundColor = NSColor(red:0.16, green:0.16, blue:0.16, alpha:1.0).cgColor
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.isMovableByWindowBackground = true
        self.view.window?.titleVisibility = NSWindowTitleVisibility.hidden
        self.view.window?.backgroundColor = NSColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)
    }
    
    func setDefaultSelectCommandsTitle() {
        commandSelectButton.removeAllItems()
        for value in CommandType.allValues {
            commandSelectButton.addItem(withTitle: value.scriptTitle)
        }
    }
    
    func setLabelText() {
        let text = getSelectedCommand().script
        commandLabel.stringValue = text
        commandLabel.textColor = NSColor.white
    }
    
    func tapExecuteButton() {
        showConfirmAlert()
    }
    
    func showConfirmAlert() {
        let alert: NSAlert = AlertView()
        alert.informativeText = getSelectedCommand().script
        let reulst = alert.runModal()
        if reulst == NSAlertFirstButtonReturn {
            excuteCommand()
            print("ok")
        } else {
            print("cancel")
        }
    }
    
    func excuteCommand() {
        let commandType = getSelectedCommand()
        let result = Command.execute(type: commandType)
        if result == 0 {
            print("success")
        } else {
            print("fail")
        }
    }
    
    func getSelectedCommand() -> CommandType {
        return CommandType.allValues[commandSelectButton.indexOfSelectedItem]
    }
}


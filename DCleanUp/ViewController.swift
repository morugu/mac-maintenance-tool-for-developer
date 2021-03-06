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
    
    let EnterKeyCode: UInt16 = 36
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear() {
        self.view.layer?.backgroundColor = NSColor(red:0.16, green:0.16, blue:0.16, alpha:1.0).cgColor
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.isMovableByWindowBackground = true
        self.view.window?.titleVisibility = NSWindowTitleVisibility.hidden
        self.view.window?.backgroundColor = NSColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)
    }
    
    func setup() {
        setDefaultSelectCommandsTitle()
        setLabelText()
        commandSelectButton.action = #selector(setLabelText)
        executeCommandButton.action = #selector(tapExecuteButton)
        executeCommandButton.title = NSLocalizedString("EXECUTE", comment: "execute")
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
        let alert: NSAlert = ConfirmAlertView()
        alert.informativeText = getSelectedCommand().script
        let reulst = alert.runModal()
        if reulst == NSAlertFirstButtonReturn {
            executeCommand()
        }
    }
    
    func showFinishAlert(success: Bool) {
        let alert: NSAlert = FinishAlertView()
        alert.informativeText = getSelectedCommand().script
        if success {
            alert.messageText = NSLocalizedString("FINISH_MESSAGE", comment: "finish message")
        } else {
            alert.messageText = NSLocalizedString("FINISH_ERROR", comment: "finish error message")        
        }
        
        alert.runModal()
    }
    
    func executeCommand() {
        let commandType = getSelectedCommand()
        let result = Command().execute(type: commandType)
        if result == 0 {
            showFinishAlert(success: true)
        } else {
            showFinishAlert(success: false)
        }
    }
    
    func getSelectedCommand() -> CommandType {
        return CommandType.allValues[commandSelectButton.indexOfSelectedItem]
    }
    
    override func keyDown(with theEvent: NSEvent) {
        if (theEvent.keyCode == EnterKeyCode) {
            showConfirmAlert()
        }
    }
}


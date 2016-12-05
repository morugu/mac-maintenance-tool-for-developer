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
        commandSelectButton.action = #selector(setLabelText)
        setLabelText()
        executeCommandButton.action = #selector(excuteCommand)
    }
    
    func setDefaultSelectCommandsTitle() {
        commandSelectButton.removeAllItems()
        for value in CommandType.allValues {
            commandSelectButton.addItem(withTitle: value.scriptFileName)
        }
    }
    
    func setLabelText() {
        let text = getSelectedCommand().script
        commandLabel.stringValue = text
    }
    
    func excuteCommand() {
        // 誤って実行しないためにコメントアウトしておく
        /*
        let commandType = getSelectedCommand()
        let result = Command.execute(type: commandType)
        if result == 0 {
            print("success")
        } else {
            print("fail")
        }
        */
    }
    
    func getSelectedCommand() -> CommandType {
        return CommandType.allValues[commandSelectButton.indexOfSelectedItem]
    }
}


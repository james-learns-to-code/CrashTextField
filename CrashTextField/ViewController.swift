//
//  ViewController.swift
//  CrashTextField
//
//  Created by akuraru on 2018/05/21.
//  Copyright © 2018年 akuraru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Have to trim because iOS force to put white space if numeric character is in front of cursor
        
        let trimmedStr = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmedStr.count > 0 else { return true }
        let canChange = string.count + (textField.text?.count ?? 0) < 5
        if
            let pasteString = UIPasteboard.general.string,
            pasteString.trimmingCharacters(in: .whitespacesAndNewlines).hasPrefix(trimmedStr) {
            print("Pasted")
            textField.undoManager?.removeAllActions()
        }
        
        // Another approach
//        let canChange = string.count + (textField.text?.count ?? 0) < 5
//        if string.contains(UIPasteboard.general.string ?? "") {
//            textField.undoManager?.removeAllActions()
//        }
        return canChange
    }
}


// Another
// subclassing uitextfiled and override paste()

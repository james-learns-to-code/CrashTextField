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
        let b = string.isEmpty || string == String(Int(string) ?? 0)
        
//        if !b {
//            textField.undoManager?.removeAllActions()
//        }
        
        return b
    }
}

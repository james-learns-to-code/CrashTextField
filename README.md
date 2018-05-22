# CrashTextField
https://qiita.com/akuraru/items/15e629bfe472f83f45f6

Sample crash when character restriction is done with UItextField

You may want to apply some restrictions on the characters entered in UITextField. For example, you want to limit the number of characters or just let you enter numbers.

A miscellaneous sample when you want to restrict only numeric input is below. This code will crash.

```
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let b = string.isEmpty || string == String(Int(string) ?? 0)
        return b
    }
}
```

## Reproduction

1. Paste restricted string
2. Shake iPhone and display Undo alert. (⌘ + ^ + Z if it is a simulator)
3. Undo
4. **Crash**

# Countermeasure 1
If you do not accept input, reset UndoManagaer. With this, user can not undo.

```swift:ViewController.swift
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let b = string.isEmpty || string == String(Int(string) ?? 0)
        
        if !b {
            textField.undoManager?.removeAllActions()
        }
        
        return b
    }
}
```

## Countermeasure 2
Disable the shaking to edit. Since this method will be invalid for the whole application, it is better to avoid it if possible.

````swift:AppDelegate.swift
application.applicationSupportsShakeToEdit = false
```

## Crash Log
A crash log occurs which is completely unknown at what line of the application it is a crash

```
2018-05-21 22:20:05.268665+0900 CrashTextField[47789:859156] *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSBigMutableString substringWithRange:]: Range {0, 38} out of bounds; string length 0'
*** First throw call stack:
(
	0   CoreFoundation                      0x00000001127fd1e6 __exceptionPreprocess + 294
	1   libobjc.A.dylib                     0x000000010ec76031 objc_exception_throw + 48
	2   CoreFoundation                      0x0000000112872975 +[NSException raise:format:] + 197
	3   Foundation                          0x000000010e663e72 -[NSString substringWithRange:] + 131
	4   UIKit                               0x0000000110360b1e -[NSTextStorage(UIKitUndoExtensions) _undoRedoAttributedSubstringFromRange:] + 136
	5   UIKit                               0x0000000110360f7d -[_UITextUndoOperationReplace undoRedo] + 319
	6   Foundation                          0x000000010e711695 -[_NSUndoStack popAndInvoke] + 280
	7   Foundation                          0x000000010e711424 -[NSUndoManager undoNestedGroup] + 433
	8   UIKit                               0x000000010f5225aa __58-[UIApplication _showEditAlertViewWithUndoManager:window:]_block_invoke.2495 + 31
	9   UIKit                               0x000000010f8db425 -[UIAlertController _invokeHandlersForAction:] + 105
	10  UIKit                               0x000000010f8dbe2a __103-[UIAlertController _dismissAnimated:triggeringAction:triggeredByPopoverDimmingView:dismissCompletion:]_block_invoke.461 + 16
	11  UIKit                               0x000000010f683d02 -[UIPresentationController transitionDidFinish:] + 1346
	12  UIKit                               0x000000010f687b72 __56-[UIPresentationController runTransitionForCurrentState]_block_invoke.436 + 183
	13  UIKit                               0x000000011026b274 -[_UIViewControllerTransitionContext completeTransition:] + 102
	14  UIKit                               0x000000010f5d410d -[UIViewAnimationBlockDelegate _didEndBlockAnimation:finished:context:] + 859
	15  UIKit                               0x000000010f5a6f09 -[UIViewAnimationState sendDelegateAnimationDidStop:finished:] + 343
	16  UIKit                               0x000000010f5a754c -[UIViewAnimationState animationDidStop:finished:] + 293
	17  UIKit                               0x000000010f5a7600 -[UIViewAnimationState animationDidStop:finished:] + 473
	18  QuartzCore                          0x00000001160117a9 _ZN2CA5Layer23run_animation_callbacksEPv + 323
	19  libdispatch.dylib                   0x000000011395d848 _dispatch_client_callout + 8
	20  libdispatch.dylib                   0x000000011396892b _dispatch_main_queue_callback_4CF + 628
	21  CoreFoundation                      0x00000001127bfc99 __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 9
	22  CoreFoundation                      0x0000000112783ea6 __CFRunLoopRun + 2342
	23  CoreFoundation                      0x000000011278330b CFRunLoopRunSpecific + 635
	24  GraphicsServices                    0x0000000115189a73 GSEventRunModal + 62
	25  UIKit                               0x000000010f5120b7 UIApplicationMain + 159
	26  CrashTextField                      0x000000010e36db77 main + 55
	27  libdyld.dylib                       0x00000001139da955 start + 1
)
```

## References
https://www.jianshu.com/p/b302a7c66741


//
//  UIViewController.swift
//  POC-chat
//
//  Created by Josué on 11/10/18.
//  Copyright © 2018 Josué. All rights reserved.
//

import UIKit

struct NotificationDescriptor<Payload> {
    let name: Notification.Name
    let convert: (Notification) -> Payload
}

extension NotificationCenter {
    
    func addObserver<Payload>(with descriptor: NotificationDescriptor<Payload>, block: @escaping (Payload) -> ()) {
        
        addObserver(forName: descriptor.name, object: nil, queue: nil) { notification in
            block(descriptor.convert(notification))
        }
    }
}

struct KeyboardPayload {
    let endFrame: CGRect
}

extension KeyboardPayload {
    
    init(notification: Notification) {
        let userInfo = notification.userInfo
        endFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
    }
}

extension UIViewController {

    static let keyboardWillShow = NotificationDescriptor(name: UIResponder.keyboardWillShowNotification, convert: KeyboardPayload.init)
    static let keyboardWillHide = NotificationDescriptor(name: UIResponder.keyboardWillHideNotification, convert: KeyboardPayload.init)

}

//
//  ViewController.swift
//  POC-chat
//
//  Created by Josué on 11/10/18.
//  Copyright © 2018 Josué. All rights reserved.
//

import UIKit
import Foundation

struct Content {
    let text: String
    var didTapReadMore: Bool
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textInput: UITextView!
    @IBOutlet weak var textInputContainer: UIView!
    @IBOutlet weak var textInputContainerBottomConstraint: NSLayoutConstraint!
    
    var messages: [Content] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addObservers()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "commentCell")
    }
    
    
    func addObservers() {
        
        NotificationCenter.default.addObserver(with: UIViewController.keyboardWillShow) {
            keyboard in
            
            self.textInputContainerBottomConstraint.constant = -keyboard.endFrame.height
        }
        
        NotificationCenter.default.addObserver(with: UIViewController.keyboardWillHide) {
            _ in
            self.textInputContainerBottomConstraint.constant = 0
        }
    }
    
    @IBAction func sendText(_ sender: Any) {
        textInput.resignFirstResponder()
        messages.append(Content(text: textInput.text, didTapReadMore: false))
        textInput.text = ""
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as? CommentCell
        
        cell?.label.text = messages[indexPath.row].text
        cell?.label.numberOfLines = messages[indexPath.row].didTapReadMore ? 0 : 2
        cell?.label.sizeToFit()
        cell?.readMoreButton.isHidden = !(cell?.label.isTruncated ?? false)
        cell?.onRequireReadMore = { [weak self] in
            self?.messages[indexPath.row].didTapReadMore = true
            self?.tableView.beginUpdates()
            cell?.setNeedsLayout()
            self?.tableView.endUpdates()
        }
        
        return cell ?? UITableViewCell()
    }
    
    
}

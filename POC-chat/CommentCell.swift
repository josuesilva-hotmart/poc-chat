//
//  CommentCell.swift
//  POC-chat
//
//  Created by Josué on 11/10/18.
//  Copyright © 2018 Josué. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    
    var onRequireReadMore: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func readMoreAction(_ sender: Any) {
        self.label.numberOfLines = 0
        self.label.sizeToFit()
        self.readMoreButton.isHidden = true
        self.onRequireReadMore?()
    }
   
}

extension UILabel {
    
    var isTruncated: Bool {
        let currentNumberOfLines = Int(self.numberOfLines)
        let startHeight = bounds.size.height
        
        self.numberOfLines = 0
        self.sizeToFit()
        
        let heightThatFits = bounds.size.height
        
        self.numberOfLines = currentNumberOfLines
        self.sizeToFit()
        
        return heightThatFits > startHeight
    }
}

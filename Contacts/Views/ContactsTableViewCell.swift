//
//  ContactTableViewCell.swift
//  ContactApp
//
//  Created by Fatih Nayebi on 2016-04-26.
//  Copyright © 2016 Fatih Nayebi. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    var contact: Contact? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var iconIsMgt: UIImageView!
    
    var attributedText: NSAttributedString {
        guard let contact = contact else { return NSAttributedString() }
        
//        let attributes: [String : AnyObject]
//        if contact.isManagement {
//            attributes = [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
//        } else {
//            attributes = [:]
//        }
        
        print("isManagement: \(contact.isManagement)")
        let fullName:String = String(contact.firstName + " " + contact.lastName)
        
        return NSAttributedString(string: fullName , attributes: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(contact: Contact) {
        store.producerForContact(contact).startWithNext { nextContact in
            self.contact = nextContact
        }
    }
    
    func updateUI() {
        guard let contact = contact else { return }
        
        textLabel?.attributedText = attributedText
        iconIsMgt.image = contact.isManagement ? UIImage(named:"mgt") : nil
    }

}

//
//  Contacts.swift
//  Contacts
//
//  Created by GER OSULLIVAN on 7/26/16.
//  Copyright © 2016 Brilliant Age. All rights reserved.
//

import ReactiveCocoa

struct ContactsViewModel {
    let contacts: [Contact]
    
    func contactForIndexPath(indexPath: NSIndexPath) -> Contact {
        return contacts[indexPath.row]
    }
}
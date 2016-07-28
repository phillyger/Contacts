//
//  DetailsContactAction.swift
//  ContactApp
//
//  Created by GER OSULLIVAN on 7/26/16.
//  Copyright © 2016 Brilliant Age. All rights reserved.
//


import Delta

struct DetailsContactAction: ActionType {
    let contact: Contact
    
    func reduce(state: State) -> State {
        state.contacts.value = state.contacts.value.map { contact in
            guard contact == self.contact else {
                
                return Contact(id: contact.id,
                        firstName: contact.firstName,
                         lastName: contact.lastName,
                     isManagement: contact.isManagement,
                           synced: contact.synced,
                         selected: false)
            }
            
            return Contact(id: self.contact.id,
                    firstName: contact.firstName,
                     lastName: contact.lastName,
                 isManagement: contact.isManagement,
                       synced: contact.synced,
                     selected: true)
        }
        
        return state
    }
}

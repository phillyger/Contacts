//
//  UpdateContactAction.swift
//  ContactApp
//
//  Created by GER OSULLIVAN on 7/26/16.
//  Copyright © 2016 Brilliant Age. All rights reserved.
//


import Delta

struct UpdateContactAction: ActionType {
    let contact: Contact
    
    func reduce(state: State) -> State {
        state.contacts.value = state.contacts.value.map {
            contact in
            guard contact == self.contact else { return contact }
            
            return Contact(id: contact.id,
                firstName: self.contact.firstName,
                lastName: self.contact.lastName,
              isManagement: self.contact.isManagement,
                    synced: !contact.synced,
                  selected: contact.selected)
        }
        
        return state
    }
}

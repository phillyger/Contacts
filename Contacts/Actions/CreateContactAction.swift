//
//  CreateContactAction.swift
//  ContactApp
//
//  Created by GER OSULLIVAN on 7/26/16.
//  Copyright © 2016 Brilliant Age. All rights reserved.
//


import Delta

struct CreateContactAction: ActionType {
    let id: Int
    let firstName: String
    let lastName: String

    var contact: Contact {
        return Contact(id: id,
                       firstName: firstName,
                       lastName: lastName,
                       isManagement: false,
                       synced: false,
                       selected: false)
    }

    func reduce(state: State) -> State {
        state.contacts.value = state.contacts.value + [contact]

        return state
    }
}

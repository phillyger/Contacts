//
//  LoadContactsAction.swift
//  ContactApp
//
//  Created by GER OSULLIVAN on 7/26/16.
//  Copyright © 2016 Brilliant Age. All rights reserved.
//


import Delta

struct LoadContactsAction: ActionType {
    let contacts: [Contact]
    
    func reduce(state: State) -> State {
        state.contacts.value = state.contacts.value + contacts
        return state
    }
}
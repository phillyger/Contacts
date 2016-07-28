//
//  DeleteContactAction.swift
//  ContactApp
//
//  Created by GER OSULLIVAN on 7/26/16.
//  Copyright © 2016 Brilliant Age. All rights reserved.
//


import Delta

struct DeleteContactAction: ActionType {
    let contact: Contact

    func reduce(state: State) -> State {
        state.contacts.value = state.contacts.value.filter { $0 != self.contact }

        return statToe
    }
}

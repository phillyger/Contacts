//
//  SetFilterAction.swift
//  ContactApp
//
//  Created by GER OSULLIVAN on 7/26/16.
//  Copyright © 2016 Brilliant Age. All rights reserved.
//

import Delta

struct SetFilterAction: ActionType {
    let filter: ContactFilter

    func reduce(state: State) -> State {
        state.filter.value = filter
        return state
    }
}

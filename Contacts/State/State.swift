//
//  State.swift
//  ContactApp
//
//  Created by Fatih Nayebi on 2016-04-25.
//  Copyright © 2016 Fatih Nayebi. All rights reserved.
//

import ReactiveCocoa

private let initialContacts: [Contact] = []

struct State {
    let contacts = MutableProperty(initialContacts)
    let filter = MutableProperty(ContactFilter.all)
    let notSynced = MutableProperty(ContactFilter.notSyncedWithBackend)
    let selectedContactItem = MutableProperty(ContactFilter.selected)
}
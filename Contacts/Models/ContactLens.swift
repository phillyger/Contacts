//
//  Contacts.swift
//  Contacts
//
//  Created by GER OSULLIVAN on 7/26/16.
//  Copyright © 2016 Brilliant Age. All rights reserved.
//

import Foundation

struct Lens<Whole, Part> {
    let get: Whole -> Part
    let set: (Part, Whole) -> Whole
}

let contactFirstNameLens: Lens<Contact, String> = Lens(
    get: { $0.firstName},
    set: {
        Contact(id: $1.id,
                firstName: $0,
                lastName: $1.lastName,
                isManagement: $1.isManagement,
                synced: $1.synced,
                selected: $1.selected)
})

let contactLastNameLens: Lens<Contact, String> = Lens(
    get: { $0.lastName},
    set: {
        Contact(id: $1.id,
                firstName: $1.firstName,
                lastName: $0,
                isManagement: $1.isManagement,
                synced: $1.synced,
                selected: $1.selected)
})


let contactIsManagementLens: Lens<Contact, Bool> = Lens(
    get: { $0.isManagement},
    set: {
        Contact(id: $1.id,
                firstName: $1.firstName,
                lastName:  $1.lastName,
                isManagement: $0,
                synced: $1.synced,
                selected: $1.selected)
})

let contactSyncedLens: Lens<Contact, Bool> = Lens(
    get: { $0.synced},
    set: {
        Contact(id: $1.id,
                firstName: $1.firstName,
                lastName:  $1.lastName,
                isManagement: $1.isManagement,
                synced: $0,
                selected: $1.selected)
})
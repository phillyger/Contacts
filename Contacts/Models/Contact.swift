//
//  Contacts.swift
//  Contacts
//
//  Created by GER OSULLIVAN on 7/26/16.
//  Copyright © 2016 Brilliant Age. All rights reserved.
//

import Argo
import Curry

enum ContactFilter: Int {
    case all
    case employees
    case management
    case notSyncedWithBackend
    case selected
}

struct Contact {
    let id: Int
    let firstName: String
    let lastName: String
    let isManagement: Bool
    let synced: Bool
    let selected: Bool?
}

extension Contact: Decodable {
    static func decode(json: JSON) -> Decoded<Contact> {
        return curry(Contact.init)
            <^> json <| "id"
            <*> json <| "firstName"
            <*> json <| "lastName"
            <*> json <| "isManagement"
            <*> json <| "synced"
            <*> json <|? "selected"
    }
}

extension Contact: Equatable {}

func == (lhs: Contact, rhs: Contact) -> Bool {
    return lhs.id == rhs.id
}
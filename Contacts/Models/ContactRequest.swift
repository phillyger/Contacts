//
//  Contacts.swift
//  Contacts
//
//  Created by GER OSULLIVAN on 7/26/16.
//  Copyright © 2016 Brilliant Age. All rights reserved.
//
import Foundation

struct ContactRequest: RequestProtocol {
    
    let id: Int
    let firstName: String
    let lastName: String
    let isManagement: Bool
    let synced: Bool
    
    subscript(key: String) -> (String?, String?) {
        get {
            switch key {
            case "id": return (String(id), "id")
            case "firstName": return (firstName, "firstName")
            case "lastName": return (lastName, "lastName")
            case "isManagement": return (String(isManagement), "isManagement")
            case "synced": return (String(synced), "synced")
            default: return ("Cookie","test=123")
            }
        }
    }
}

struct RequestModel: RequestProtocol {
    subscript(key: String) -> (String?, String?) {
        get {
            switch key {
            default: return ("Cookie","test=123")
            }
        }
    }
}
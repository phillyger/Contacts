//
//  ContactManager.swift
//  ContactApp
//
//  Created by Fatih Nayebi on 2016-04-25.
//  Copyright © 2016 Fatih Nayebi. All rights reserved.
//

import Alamofire
import Argo

func addContact(completion:(responseData:[Contact]?, error: NSError?) -> Void) {
    let newRequest = ContactRequest(id: 1,
                          firstName: "Tom",
                           lastName: "Jones",
                       isManagement: false,
                             synced: true)
    
    sendRequest(Urls.postContact, request: newRequest) {
        (response, error) in
        if error == nil {
            let contacts: [Contact]? = decode(response!)
            completion(responseData: contacts, error: nil)
            print("request was successfull: \(contacts)")
        } else {
            completion(responseData: nil, error: error)
            print("Error: \(error?.localizedDescription)")
        }
    }
}

func listContacts(completion:(responseData:[Contact]?, error: NSError?) -> Void) {
    sendRequest(Urls.getContacts, request: RequestModel()) {
        (response, error) in
        if error == nil {
            let contacts: [Contact]? = decode(response!)
            completion(responseData: contacts, error: nil)
            print("request was successfull: \(contacts)")
        } else {
            completion(responseData: nil, error: error)
            print("Error: \(error?.localizedDescription)")
        }
    }
}

func addOrUpdateContact(contact: [Contact]?, completion:(responseData:[Contact]?, error: NSError?) -> Void) {
    if let contactItem = contact?.first {
        let newRequest = ContactRequest(id: contactItem.id,
                              firstName: contactItem.firstName,
                               lastName: contactItem.lastName,
                           isManagement: contactItem.isManagement,
                                 synced: true)
        
        sendRequest(Urls.postContact, request: newRequest) {
            (response, error) in
            if error == nil {
                let contacts: [Contact]? = decode(response!)
                let newContact = contactSyncedLens.set(true, contactItem)
                store.dispatch(UpdateContactAction(contact: newContact))
                completion(responseData: contacts, error: nil)
                print("request was successfull: \(contacts)")
            } else {
                completion(responseData: nil, error: error)
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
}

func updateContact(contact: [Contact]?, completion:(responseData:[Contact]?, error: NSError?) -> Void) {
    if let contactItem = contact?.first {
        let newRequest = ContactRequest(id: contactItem.id,
                                 firstName: contactItem.firstName,
                                  lastName: contactItem.lastName,
                              isManagement: contactItem.isManagement,
                                    synced: true)
        
        sendRequest(Urls.update, request: newRequest) {
            (response, error) in
            if error == nil {
                let contacts: [Contact]? = decode(response!)
                let newContact = contactSyncedLens.set(true, contactItem)
                store.dispatch(UpdateContactAction(contact: newContact))
                completion(responseData: contacts, error: nil)
                print("request was successfull: \(contacts)")
            } else {
                completion(responseData: nil, error: error)
                print("Error: \(error?.localizedDescription)")
            }
        }
        
    }
}

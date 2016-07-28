//
//  StoreExtensions.swift
//  ContactApp
//
//  Created by Fatih Nayebi on 2016-04-25.
//  Copyright © 2016 Fatih Nayebi. All rights reserved.
//

import ReactiveCocoa
import Result

// MARK: Properties
extension Store {
    var contacts: MutableProperty<[Contact]> {
        return state.value.contacts
    }
    
    var activeFilter: MutableProperty<ContactFilter> {
        return state.value.filter
    }
    
    var selectedContactItem: MutableProperty<ContactFilter> {
        return state.value.selectedContactItem
    }
    
}

// MARK: SignalProducers
extension Store {
    var activeContacts: SignalProducer<[Contact], NoError> {
        return activeFilter.producer.flatMap(.Latest) {
            filter -> SignalProducer<[Contact], NoError> in
            switch filter {
            case .all: return self.contacts.producer
            case .employees: return self.employeeContacts
            case .management: return self.managementContacts
            case .notSyncedWithBackend: return self.notSyncedWithBackend
            case .selected: return self.selectedContact
            }
        }
    }
    
    var managementContacts: SignalProducer<[Contact], NoError> {
        return contacts.producer.map {
            contacts in
            return contacts.filter { $0.isManagement }
        }
    }
    
    
    var  employeeContacts: SignalProducer<[Contact], NoError> {
        return contacts.producer.map {
            contacts in
            return contacts.filter { !$0.isManagement }
        }
    }
    
    var employeeContactsCount: SignalProducer<Int, NoError> {
        return employeeContacts.map { $0.count }
    }
    
    var allContactsCount: SignalProducer<Int, NoError> {
        return contacts.producer.map { $0.count }
    }
    
//    var contactStats: SignalProducer<(Int, Int), NoError> {
//       return allContactsCount.zipWith(employeeContactsCount)
//
//    }
    
    var notSyncedWithBackend: SignalProducer<[Contact], NoError> {
        return contacts.producer.map {
            contacts in
            return contacts.filter { !$0.synced }
        }
    }
    
    var selectedContact: SignalProducer<[Contact], NoError> {
        return contacts.producer.map {
            contacts in
            return contacts.filter {
                contact in
                if let selected = contact.selected {
                    return selected
                } else {
                    return false
                }
            }
        }
    }
    
    func producerForContact(contact: Contact) -> SignalProducer<Contact, NoError> {
        return store.contacts.producer.map {
            contacts in
            return contacts.filter { $0 == contact }.first
        }.ignoreNil()
    }
}


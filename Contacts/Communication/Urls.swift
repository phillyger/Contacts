//
//  Urls.swift
//  ContactApp
//
//  Created by Fatih Nayebi on 2016-04-25.
//  Copyright © 2016 Fatih Nayebi. All rights reserved.
//

import Foundation
import Alamofire

enum Urls {
    case postContact
    case getContacts
    case getContact
    case deleteContact
    case deleteAll
    case update
}

extension Urls {
    func httpMethodUrl() -> (Alamofire.Method, String) {
        let baseUrl = "http://localhost:8080/"
        switch self {
        case .postContact:
            return (.POST, "\(baseUrl)postContact")
        case .getContacts:
            return (.GET, "\(baseUrl)contacts")
        case .getContact:
            return (.GET, "\(baseUrl)contact")
        case .deleteContact:
            return (.DELETE, "\(baseUrl)deleteContact")
        case .deleteAll:
            return (.DELETE, "\(baseUrl)deleteAll")
        case .update:
            return (.POST, "\(baseUrl)updateContact")
        }
    }
}
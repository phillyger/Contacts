//
//  DetailsViewController.swift
//  ContactApp
//
//  Created by Fatih Nayebi on 2016-04-29.
//  Copyright © 2016 Fatih Nayebi. All rights reserved.
//

import UIKit
import ReactiveCocoa

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var txtFieldFirstName: UITextField!
    @IBOutlet weak var txtFieldLastName: UITextField!
    @IBOutlet weak var switchIsManagement: UISwitch!
    
    var viewModel = ContactViewModel(contact: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.selectedContact.startWithNext { Contacts in
            let model = Contacts.first!
            self.txtFieldFirstName.text = model.firstName
            self.txtFieldLastName.text = model.lastName
            self.switchIsManagement.on = model.isManagement
            self.viewModel = ContactViewModel(contact: model)
        }
        setupUpdateSignals()
    }
    
    func setupUpdateSignals()  {
        txtFieldFirstName.rac_textSignal().subscribeNext {
            (next: AnyObject!) -> () in
            if let newFirstName = next as? String {
                let newContact = contactFirstNameLens.set(newFirstName, self.viewModel.contact!)
                store.dispatch(UpdateContactAction(contact: newContact))
            }
        }
        
        txtFieldLastName.rac_textSignal().subscribeNext {
            (next: AnyObject!) -> () in
            if let newLastName = next as? String {
                let newContact = contactLastNameLens.set(newLastName, self.viewModel.contact!)
                store.dispatch(UpdateContactAction(contact: newContact))
            }
        }
        
        
        switchIsManagement.rac_newOnChannel().subscribeNext {
            (next: AnyObject!) -> () in
            if let newIsManagement = next as? Bool {
                let newContact = contactIsManagementLens.set(newIsManagement, self.viewModel.contact!)
                store.dispatch(UpdateContactAction(contact: newContact))

            }
        }
    }
}

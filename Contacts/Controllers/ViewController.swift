//
//  ViewController.swift
//
//  Contacts
//
//  Created by GER OSULLIVAN on 7/26/16.
//  Copyright © 2016 Brilliant Age. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    
    var viewModel = ContactsViewModel(contacts: []) {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listContacts() {
            (response, error) in
            if error == nil {
                store.dispatch(LoadContactsAction(contacts: response!))
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
        filterSegmentedControl.addTarget(self, action: #selector(ViewController.filterValueChanged), forControlEvents: .ValueChanged)
        
        store.activeFilter.producer.startWithNext {
            filter in
            self.filterSegmentedControl.selectedSegmentIndex = filter.rawValue
        }
        
        store.activeContacts.startWithNext {
            contacts in
            self.viewModel = ContactsViewModel(contacts: contacts)
        }
        
        store.notSyncedWithBackend.startWithNext {
            contacts in
            addOrUpdateContact(contacts) { (response, error) in
                if error == nil {
                    print("Success")
                } else {
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }
    }
}

// MARK: Actions
extension ViewController {
    @IBAction func addTapped(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Create",
                                              message: "Create a new  contact",
                                       preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler() {
            textField in
            textField.placeholder = "Id"
        }
        
        alertController.addTextFieldWithConfigurationHandler() {
            textField in
            textField.placeholder = "First Name"
        }
        
        alertController.addTextFieldWithConfigurationHandler() {
            textField in
            textField.placeholder = "Last Name"
        }
        

        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel) { _ in })
        
        alertController.addAction(UIAlertAction(title: "Create", style: .Default) { _ in
            guard let id = alertController.textFields?[0].text,
                firstName = alertController.textFields?[1].text,
                lastName = alertController.textFields?[2].text
                else { return }
            
            store.dispatch(CreateContactAction(id: Int(id)!,
                firstName: firstName,
                lastName: lastName))
            })
        presentViewController(alertController, animated: false, completion: nil)
    }
    
    func filterValueChanged() {
        guard let newFilter = ContactFilter(rawValue: filterSegmentedControl.selectedSegmentIndex)
            else { return }
        
        store.dispatch(SetFilterAction(filter: newFilter))
    }
}

// MARK: UITableViewController
extension ViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath) as! ContactTableViewCell
        let contact = viewModel.contactForIndexPath(indexPath)
        
        cell.configure(contact)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let contact = viewModel.contactForIndexPath(indexPath)
        store.dispatch(ToggleIsManagementAction(contact: contact))
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
            let contact = self.viewModel.contactForIndexPath(indexPath)
            store.dispatch(DeleteContactAction(contact: contact))
        }
        delete.backgroundColor = UIColor.redColor()
        
        let details = UITableViewRowAction(style: .Normal, title: "Details") { action, index in
            let contact = self.viewModel.contactForIndexPath(indexPath)
            store.dispatch(DetailsContactAction(contact: contact))
            
            self.performSegueWithIdentifier("segueShowDetails", sender: self)
        }
        details.backgroundColor = UIColor.orangeColor()
        
        return [details, delete]
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear need to be editable
        return true
    }
}






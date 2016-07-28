//
//  FooterView.swift
//  ContactApp
//
//  Created by Fatih Nayebi on 2016-04-29.
//  Copyright © 2016 Fatih Nayebi. All rights reserved.
//


import UIKit

class FooterView: UIView {
    var stackView: UIStackView? {
        return self.subviews.first as? UIStackView
    }
    
    var numberOfEmployeesLabel: UILabel? {
        return stackView?.subviews.first as? UILabel
    }
    
    var clearIsManagementButton: UIButton? {
        return stackView?.subviews.last as? UIButton
    }
    
    override func awakeFromNib() {
        self.clearIsManagementButton?.addTarget(self, action: #selector(FooterView.clearCompletedTapped), forControlEvents: .TouchUpInside)
        self.subscribeToStoreChanges()
    }
    
    func subscribeToStoreChanges() {
        store.allContactsCount.startWithNext { allContactsCount in
            self.clearIsManagementButton?.hidden = 0 == allContactsCount
            
            if allContactsCount == 1 {
                self.numberOfEmployeesLabel?.text = "1 employee"
            } else {
                self.numberOfEmployeesLabel?.text = "\(allContactsCount) employees"
            }
        }
    }
    
    func clearCompletedTapped() {
//        store.dispatch(ClearIsMangementContactsAction())
    }
}

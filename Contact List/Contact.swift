//
//  Contact.swift
//  Contact List
//
//  Created by Yuen Shan Tsang on 16/4/2023.
//

import Foundation

class Contact {
    var name: String
    var phoneNumber: String
    var email: String
    var address: String
    
    init(name: String, phoneNumber: String, email: String, address: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
    }

}

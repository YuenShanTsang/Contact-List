//
//  Contact.swift
//  Contact List
//
//  Created by Yuen Shan Tsang on 16/4/2023.
//

import Foundation

class Contact {
    var name: String
    var phoneNumber: Int
    var email: String
    
    init(name: String, phoneNumber: Int, email: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }

}

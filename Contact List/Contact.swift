//
//  Contact.swift
//  Contact List
//
//  Created by Yuen Shan Tsang on 16/4/2023.
//

import Foundation

class Contact: NSObject, NSCoding, NSSecureCoding {
    
    // Declare a static property to indicate whether the class supports secure coding
    static var supportsSecureCoding: Bool = true
    
    // Declare properties
    var name: String
    var phoneNumber: String
    var email: String
    var address: String
    
    // Initializer
    init(name: String, phoneNumber: String, email: String, address: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
    }
    
    // Implement the required initializer for NSCoding, which decodes the contact's information from a NSCoder
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        phoneNumber = coder.decodeObject(forKey: "phoneNumber") as! String
        email = coder.decodeObject(forKey: "email") as! String
        address = coder.decodeObject(forKey: "address") as! String
    }
    
    // Implement the encode method from the NSCoding protocol, which encodes the contact's information using a NSCoder
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(phoneNumber, forKey: "phoneNumber")
        coder.encode(email, forKey: "email")
        coder.encode(address, forKey: "address")
    }
    
}

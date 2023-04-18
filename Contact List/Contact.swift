//
//  Contact.swift
//  Contact List
//
//  Created by Yuen Shan Tsang on 16/4/2023.
//

import Foundation

class Contact: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
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
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        phoneNumber = coder.decodeObject(forKey: "phoneNumber") as! String
        email = coder.decodeObject(forKey: "email") as! String
        address = coder.decodeObject(forKey: "address") as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(phoneNumber, forKey: "phoneNumber")
        coder.encode(email, forKey: "email")
        coder.encode(address, forKey: "address")
    }
    

}

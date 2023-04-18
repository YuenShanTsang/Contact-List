//
//  ContactList.swift
//  Contact List
//
//  Created by Yuen Shan Tsang on 17/4/2023.
//

import Foundation

class ContactList{
    var contacts: [Contact] = []
    
    init(){
        contacts.append(Contact(name: "Clary", phoneNumber: "(123)456-7890", email: "email1@gmail.com", address: "adevett"))
        contacts.append(Contact(name: "A", phoneNumber: "112343435", email: "email2@gmail.com", address: "adevett"))
        contacts.append(Contact(name: "B", phoneNumber: "32144352", email: "email3@gmail.com", address: "adevett"))
        contacts.append(Contact(name: "joshua.vandermost", phoneNumber: "+1 (123)456-7890", email: "joshua.vandermost@cambriancollege.ca", address: "adevevdfrvbgftbdrftgbtdrfbhtrgbhgfnyjnuyjtjnntyjhytjuyrtt"))
    }
    
    func delete(at indexPath: IndexPath){
        let row = indexPath.row
        
        contacts.remove(at: row)
    }
    
    func move(from fromIndexPath: IndexPath, to toIndexPath: IndexPath){
        let tmp = contacts[fromIndexPath.row]
        
        delete(at: fromIndexPath)
        
        contacts.insert(tmp, at: toIndexPath.row)
    }
}

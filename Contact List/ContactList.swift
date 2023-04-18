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
        contacts.append(Contact(name: "Clary", phoneNumber: 12345678, email: "email1@gmail.com"))
        contacts.append(Contact(name: "A", phoneNumber: 112343435, email: "email2@gmail.com"))
        contacts.append(Contact(name: "B", phoneNumber: 32144352, email: "email3@gmail.com"))
        contacts.append(Contact(name: "C", phoneNumber: 32543543, email: "email4@gmail.com"))
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

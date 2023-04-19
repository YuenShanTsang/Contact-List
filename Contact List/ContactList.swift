//
//  ContactList.swift
//  Contact List
//
//  Created by Yuen Shan Tsang on 17/4/2023.
//

import Foundation

class ContactList{
    var contacts: [Contact] = []
    
    private let contactURL: URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appending(path: "contact.archive")
    }()
    
    init(){
        let data = try? Data(contentsOf: contactURL)
        if data == nil { return }
        
        contacts = try! NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: Contact.self, from: data!)!
    }
    
    func save(){
        do{
            let encodedContacts = try NSKeyedArchiver.archivedData(withRootObject: contacts, requiringSecureCoding: true)
            try encodedContacts.write(to: contactURL)
            print("All objects were saved")
        } catch let err{
            preconditionFailure(err.localizedDescription)
        }
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
    
    func add(_ contact: Contact) {
        contacts.append(contact)
    }
    
    func setContacts(_ newContacts: [Contact]) {
        self.contacts = newContacts
    }
    
    func search(for searchText: String) -> [Contact] {
        let normalizedSearchText = searchText.lowercased()
        let searchResults = contacts.filter { $0.name.lowercased().contains(normalizedSearchText) }
        return searchResults
    }
}

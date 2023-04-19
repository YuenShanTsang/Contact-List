//
//  ContactList.swift
//  Contact List
//
//  Created by Yuen Shan Tsang on 17/4/2023.
//

import Foundation

class ContactList{
    var contacts: [Contact] = []
    
    // URL where the contacts will be saved
    private let contactURL: URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appending(path: "contact.archive")
    }()
    
    
    // Initializes the ContactList with the saved contacts, if any
    init(){
        let data = try? Data(contentsOf: contactURL)
        if data == nil { return }
        
        contacts = try! NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: Contact.self, from: data!)!
    }
    
    
    // Saves the contacts to the contactURL
    func save(){
        do{
            let encodedContacts = try NSKeyedArchiver.archivedData(withRootObject: contacts, requiringSecureCoding: true)
            try encodedContacts.write(to: contactURL)
            print("All objects were saved")
        } catch let err{
            preconditionFailure(err.localizedDescription)
        }
    }
    
    
    // Deletes the contact at a given index path
    func delete(at indexPath: IndexPath){
        let row = indexPath.row
        contacts.remove(at: row)
    }
    
    
    // Moves a contact from one index path to another
    func move(from fromIndexPath: IndexPath, to toIndexPath: IndexPath){
        let tmp = contacts[fromIndexPath.row]
        delete(at: fromIndexPath)
        contacts.insert(tmp, at: toIndexPath.row)
    }
    
    
    // Adds a new contact to the contacts array
    func add(_ contact: Contact) {
        contacts.append(contact)
    }
    
    
    // Sets the contacts array to a new set of contacts
    func setContacts(_ newContacts: [Contact]) {
        self.contacts = newContacts
    }
    
    
    // Searches for contacts containing a given search text and returns them in an array
    func search(for searchText: String) -> [Contact] {
        let normalizedSearchText = searchText.lowercased()
        let searchResults = contacts.filter { $0.name.lowercased().contains(normalizedSearchText) }
        return searchResults
    }
}

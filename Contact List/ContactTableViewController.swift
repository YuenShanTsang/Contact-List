//
//  ContactTableViewController.swift
//  Contact List
//
//  Created by Yuen Shan Tsang on 16/4/2023.
//

import UIKit

class ContactTableViewController: UITableViewController {
    
    // The main contact list
    var contactList: ContactList!
    
    // The contact list used for search results
    var searchResults: ContactList!
    
    // Search contact function
    @IBAction func search(_ sender: UIBarButtonItem) {
        
        // Check if searchController is nil
        if navigationItem.searchController == nil {
            
            // Create a new searchController
            let searchController = UISearchController(searchResultsController: nil)
            
            // Set the delegate for handling search updates
            searchController.searchResultsUpdater = self
            
            // Don't dim the background while searchController is presented
            searchController.obscuresBackgroundDuringPresentation = false
            
            // Set the placeholder text for the search bar
            searchController.searchBar.placeholder = NSLocalizedString("Search Contacts", comment: "to search contacts by name")
            
            // Assign the searchController to the navigation item
            navigationItem.searchController = searchController
            
            // Keep the search bar visible when the user scrolls
            navigationItem.hidesSearchBarWhenScrolling = false
            
            // Ensure that the searchController is presented within the current view controller
            definesPresentationContext = true
            
        } else {
            
            // Remove the searchController from the navigation item
            navigationItem.searchController = nil
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        // Add an "Edit" button to the left side of the navigation bar
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // Reload the table view to ensure it reflects the latest data
        tableView.reloadData()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        // One section in the table view
        return 1
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        // Return the number of rows in the table view based on whether we're showing search results
        if let results = searchResults {
            return results.contacts.count
        }
        
        return contactList.contacts.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell object with the identifier "contactCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        
        // Configure the cell...
        
        // Get the row number for the current cell
        let row = indexPath.row
        
        var currentContact: Contact
        
        // Check if search is active and if so, use the search results, else use the full contact list
        if let results = searchResults {
            currentContact = results.contacts[row]
        } else {
            currentContact = contactList.contacts[row]
        }
        
        // Set the text of the cell's labels to the corresponding contact information
        cell.nameLabel.text = currentContact.name
        cell.phoneNumberLabel.text = currentContact.phoneNumber
        cell.emailLabel.text = currentContact.email
        cell.addressLabel.text = currentContact.address
        
        // Return the configured cell
        return cell
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            contactList.delete(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
    }
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        contactList.move(from: fromIndexPath, to: to)
    }
    
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Identify the segue
        switch segue.identifier {
        
        // If the segue is to add a new contact
        case "add":
            // Pass the contact list to the destination view controller
            let dst = segue.destination as! DetailsViewController
            dst.contactList = contactList
        
        // If the segue is to edit an existing contact
        case "edit":
            // Pass the contact list to the destination view controller
            let dst = segue.destination as! DetailsViewController
            dst.contactList = contactList
            
            // Get the selected contact
            let indexPath = tableView.indexPathForSelectedRow!
            let index = indexPath.row
            let contact = contactList.contacts[index]
            
            // Pass the selected contact to the destination view controller
            dst.contact = contact
    
        // If the segue has an unidentified identifier
        default:
            preconditionFailure("unidentified segue ID: \(segue.identifier)")
        }
    }
    
}

// UISearchResultsUpdating method
extension ContactTableViewController: UISearchResultsUpdating {
    
    // Called when the search bar text changes
    func updateSearchResults(for searchController: UISearchController) {
        
        // Get the search bar text, and filter the contacts based on that text
        let searchText = searchController.searchBar.text ?? ""
        
        // Check if the search bar is empty
        if searchText.isEmpty {
            
            // If it is, use the original contact list as the search results
            searchResults = contactList
            
        } else {
            
            // If the search bar is not empty, filter the contacts based on the search text
            let filteredContacts = contactList.search(for: searchText)
            
            // Create a new ContactList object to store the search results
            searchResults = ContactList()
            
            // Set the contacts in the searchResults object to the filtered contacts
            searchResults.setContacts(filteredContacts)
            
        }
        
        // Reload the table view data to display the filtered results
        tableView.reloadData()
    }
    
}

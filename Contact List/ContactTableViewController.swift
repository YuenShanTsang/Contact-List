//
//  ContactTableViewController.swift
//  Contact List
//
//  Created by Yuen Shan Tsang on 16/4/2023.
//

import UIKit

class ContactTableViewController: UITableViewController {

    var contactList: ContactList!
    
    var searchResults: ContactList!
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        
        if navigationItem.searchController == nil {
                let searchController = UISearchController(searchResultsController: nil)
                searchController.searchResultsUpdater = self
                searchController.obscuresBackgroundDuringPresentation = false
                searchController.searchBar.placeholder = NSLocalizedString("Search Contacts", comment: "")
                navigationItem.searchController = searchController
                navigationItem.hidesSearchBarWhenScrolling = false
                definesPresentationContext = true
            } else {
                navigationItem.searchController = nil
            }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contactList.contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell

        // Configure the cell...
        let row = indexPath.row
        let currentContact = contactList.contacts[row]
    
        cell.contact = currentContact
        
        cell.nameLabel.text = currentContact.name
        cell.phoneNumberLabel.text = currentContact.phoneNumber
        cell.emailLabel.text = currentContact.email
        cell.addressLabel.text = currentContact.address
        
    
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

        switch segue.identifier {
        case "add":
            let dst = segue.destination as! DetailsViewController
            dst.contactList = contactList
        
        case "edit":
            let dst = segue.destination as! DetailsViewController
            dst.contactList = contactList
            let indexPath = tableView.indexPathForSelectedRow!
            let index = indexPath.row
            let contact = contactList.contacts[index]
            dst.contact = contact
        default:
            preconditionFailure("unidentified segue ID: \(segue.identifier)")
        }
    }

}

extension ContactTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        searchResults = searchText.isEmpty ? contactList : contactList.search(for: searchText)
        tableView.reloadData()
    }
}

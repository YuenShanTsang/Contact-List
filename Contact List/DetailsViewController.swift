//
//  DetailsViewController.swift
//  Contact List
//
//  Created by Yuen Shan Tsang on 17/4/2023.
//

import UIKit

class DetailsViewController: UIViewController {

    var contactList: ContactList!
    
    var contactNameCheck: String = ""
    var contactPhoneNumberCheck: String = ""
    var contactEmailCheck: String = ""
    var contactAddressCheck: String = ""
    
    var contact: Contact!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBAction func save(_ sender: Any) {
        saveContact()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard
            (contact != nil)
        else {return}
        nameTextField.text = contact.name
        phoneNumberTextField.text = contact.phoneNumber
        emailTextField.text = contact.email
        addressTextField.text = contact.address
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveContact()
        
    }
    
    func saveContact(){
        let name = nameTextField.text!
        let phoneNumber = phoneNumberTextField.text!
        let email = emailTextField.text!
        let address = addressTextField.text!

            
        if name == "" {return}
        if phoneNumber == "" {return}
        if email == "" {return}
        if address == "" {return}
            
        if name == contactNameCheck {return}
        if phoneNumber == contactPhoneNumberCheck {return}
        if email == contactEmailCheck {return}
        if address == contactAddressCheck {return}
            
        contactNameCheck = name
        contactPhoneNumberCheck = phoneNumber
        contactEmailCheck = email
        contactAddressCheck = address
        
        if contact == nil {
            let newContact = Contact(name: name, phoneNumber: phoneNumber, email: email, address: address)
            
            contactList.contacts.append(newContact)
            contact = newContact
        } else {
            contact.name = name
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

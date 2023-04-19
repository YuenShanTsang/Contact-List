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
    
    var width: CGFloat!
    
    var contactSaved = false

    
    @IBOutlet weak var savedConstraint: NSLayoutConstraint!
    @IBOutlet weak var savedLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    
    @IBAction func save(_ sender: UIButton) {
        saveContact()
            
        if contact == nil || !contactSaved {
            // Contact was not saved successfully
            return
        }
        
        UIView.animate(withDuration: 2.5) {
            self.savedLabel.alpha = 1
        }
        
        UIView.animate(withDuration: 5){
            [self] in
            savedConstraint.constant = width
            view.layoutIfNeeded()
        } completion: {
            [self] _ in
            
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            } else {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        width = view.frame.width
        
        savedLabel.alpha = 0
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

        if name.isEmpty || phoneNumber.isEmpty {
            let title = NSLocalizedString("Missing Information", comment: "Title of alert when required information is missing")
            let message = NSLocalizedString("Please enter a name and phone number to save the contact.", comment: "Message of alert when required information is missing")

            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            contactSaved = false
            return
        }

        if name == "" {
                contactSaved = false
                return
            }
            if phoneNumber == "" {
                contactSaved = false
                return
            }

            if name == contactNameCheck {
                contactSaved = true
                return
            }
            if phoneNumber == contactPhoneNumberCheck {
                contactSaved = true
                return
            }
            
        contactNameCheck = name
        contactPhoneNumberCheck = phoneNumber

        if contact == nil {
            let newContact = Contact(name: name, phoneNumber: phoneNumber, email: email, address: address)
            contactList.contacts.append(newContact)
            contact = newContact
        } else {
            contact.name = name
            contact.phoneNumber = phoneNumber
            contact.email = email
            contact.address = address
        }
        
        contactSaved = true
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

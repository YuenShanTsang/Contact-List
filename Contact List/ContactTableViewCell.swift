//
//  ContactTableViewCell.swift
//  Contact List
//
//  Created by Yuen Shan Tsang on 18/4/2023.
//

import UIKit

// Define a custom UITableViewCell for displaying a contact's information
class ContactTableViewCell: UITableViewCell {

    var contact: Contact!
    
    // Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  UserTableViewCell.swift
//  GCDPractice
//
//  Created by Shawn Li on 6/19/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureUserTextInfo(name: String, id: Int, email: String, image: UIImage?)
    {
        nameLabel.text = name
        emailLabel.text = email
        profileImageView.image = image
        idLabel.text = String(id)
    }
    
}

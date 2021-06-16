//
//  MyListTableViewCell.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 19.05.2021.
//

import UIKit

class MyListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var reminderTextLabel: UILabel!
    @IBOutlet weak var numberOfReminderLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
   
}



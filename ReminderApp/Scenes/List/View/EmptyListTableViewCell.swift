//
//  EmptyListTableViewCell.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 20.05.2021.
//

import UIKit

class EmptyListTableViewCell: UITableViewCell {
    @IBOutlet weak var emptyListView: UIView!
 
    @IBOutlet weak var emptyListTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//
//  AddListCollectionViewCell.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 19.05.2021.
//

import UIKit

class AddListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addListView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure (){
        addListView.layer.cornerRadius = 20
        addListView.layer.masksToBounds = true
        addListView.layer.borderWidth = 1
        addListView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
    }
    

   

}

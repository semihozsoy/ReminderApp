//
//  MainCategoryCollectionViewCell.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 17.05.2021.
//

import UIKit

class MainCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var reminderImage: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var numberOfReminderLbl: UILabel!
    @IBOutlet weak var mainCategoryView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     configure()
    }
    
    func configure(){
        mainCategoryView.frame.size = CGSize(width: 350, height: 50)
        mainCategoryView.layer.cornerRadius = 20
        mainCategoryView.layer.masksToBounds = true
        mainCategoryView.layer.borderWidth = 1
        mainCategoryView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
    }

}

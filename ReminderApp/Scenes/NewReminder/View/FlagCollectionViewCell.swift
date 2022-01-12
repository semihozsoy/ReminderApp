//
//  FlagCollectionViewCell.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 17.05.2021.
//

import UIKit

class FlagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var flagSwitch: UISwitch!
    @IBOutlet weak var flagView: UIView!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    
    var delegate: FlagProtocolDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureNib()
        flagSwitch.addTarget(self, action: #selector(switchDidChange), for: UIControl.Event.valueChanged)
    }
    func configureNib(){
        flagView.frame.size = CGSize(width: 350, height: 50)
        flagView.layer.cornerRadius = 20
        flagView.layer.masksToBounds = true
        flagView.layer.borderWidth = 1
        flagView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        
    }
   @objc func switchDidChange(){
        switch flagSwitch.isOn {
        case true:
            delegate?.flagDidChange(flag: true)
        case false:
            delegate?.flagDidChange(flag: false)
        }
    }
}

protocol FlagProtocolDelegate{
    func flagDidChange(flag: Bool)
}



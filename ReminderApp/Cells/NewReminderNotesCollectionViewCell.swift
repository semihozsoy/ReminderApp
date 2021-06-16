//
//  NewReminderNotesCollectionViewCell.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 17.05.2021.
//

import UIKit
import CoreData

protocol MyDataSendingDelegateProtocol {
    func sendTitleDatatoViewController(titleTextField: String)
    func sendNotesDatatoViewController(notesTextField: String)
}

class NewReminderNotesCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier: String = "NewReminderNotesCollectionViewCell"
    @IBOutlet weak var newNotesView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    var Title: String?
    var Notes: String?
    
    var delegate: MyDataSendingDelegateProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureNib()
        
        titleTextField.delegate = self
        notesTextField.delegate = self
    }
    
    func configureNib(){
        newNotesView.frame.size = CGSize(width: 350, height: 250)
        newNotesView.layer.cornerRadius = 20
        newNotesView.layer.masksToBounds = true
        newNotesView.layer.borderWidth = 1
        newNotesView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
    }
}

extension NewReminderNotesCollectionViewCell: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
       print(delegate==nil)
        if textField.tag == 0 {
            let title = self.titleTextField.text ?? ""
            self.delegate?.sendTitleDatatoViewController(titleTextField: title)
        }else if textField.tag == 1 {
            let notes = self.notesTextField.text ?? ""
            self.delegate?.sendNotesDatatoViewController(notesTextField: notes)
        }
       
        
    }
    
    
}







//
//  PriorityCollectionViewCell.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 17.05.2021.
//

import UIKit

class PriorityCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var priorityTextField: UITextField!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var priorityView: UIView!
    
    let priority = ["None","Normal","Low","Medium","High"]
    let picker = UIPickerView()
    var delegate: PriorityProtocolDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        picker.dataSource = self
        picker.delegate = self
        configureNib()
        priorityTextField.inputView = picker
        toolPriorityBar()
    }
    
    func toolPriorityBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let okButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(dismissButton))
        
        toolBar.setItems([okButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        priorityTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func dismissButton (){
        contentView.endEditing(true) 
    }
    
    func configureNib(){
        priorityView.layer.cornerRadius = 20
        priorityView.layer.masksToBounds = true
        priorityView.layer.borderWidth = 1
        priorityView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        
    }

}

extension PriorityCollectionViewCell: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priority.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priority[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priorityTextField.text = priority[row]
        delegate?.didSendPriority(priority: priority[row])
    }
}

protocol PriorityProtocolDelegate {
    func didSendPriority(priority: String)
}


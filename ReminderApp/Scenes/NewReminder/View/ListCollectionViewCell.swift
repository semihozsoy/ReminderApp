//
//  ListtCollectionViewCell.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 17.05.2021.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var listView: UIView!

    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var listTextField: UITextField!
    
    let picker = UIPickerView()
    var source = [List]()
    var delegate: SelectListDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureNib()
        picker.dataSource = self
        picker.delegate = self
        listTextField.inputView = picker
    
        toolBar()
    }


    func toolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let okButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(dismissButton))

        toolBar.setItems([okButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        listTextField.inputAccessoryView = toolBar

    }

    @objc func dismissButton (){
        contentView.endEditing(true) 
    }

    func configureNib(){
        listView.frame.size = CGSize(width: 350, height: 50)
        listView.layer.cornerRadius = 20
        listView.layer.masksToBounds = true
        listView.layer.borderWidth = 1
        listView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
    }
}

extension ListCollectionViewCell: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return source.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return source[row].listText
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if source.count > 0{
            listTextField.text = source[row].listText
            delegate?.didSelectList(listText: source[row].listText ?? "")
        }
    }
}

protocol SelectListDelegate {
    func didSelectList(listText: String)
}

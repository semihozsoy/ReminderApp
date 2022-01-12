//
//  NewReminderViewController.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 14.05.2021.
//

import UIKit
import CoreData

class NewReminderViewController: UIViewController{
    
    @IBOutlet weak var newReminderNotesCollectionView: UICollectionView!
    
    let priority = ["None","Normal","Low","Medium","High"]
    let picker = UIPickerView()
    var listArr = [List]()
    var myNewList: List?
    var reminder: Reminder?
    var listTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newReminderNotesCollectionView.delegate = self
        newReminderNotesCollectionView.dataSource = self
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        reminder = Reminder(context: context)
        do {
            self.listArr = try context.fetch(List.fetchRequest()) as! [List]
        } catch  {
            print("error")
        }
       
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNewReminder))
        
        
        let newReminderNotesNib = UINib(nibName: "NewReminderNotesCollectionViewCell", bundle: .main)
        newReminderNotesCollectionView.register(newReminderNotesNib, forCellWithReuseIdentifier: "NewReminderNotesCollectionViewCell")
        
        let listCollectionNib = UINib(nibName: "ListCollectionViewCell", bundle: .main)
        newReminderNotesCollectionView.register(listCollectionNib, forCellWithReuseIdentifier: "listIdentifier")
        
        let priorityCollectionNib = UINib(nibName: "PriorityCollectionViewCell", bundle: .main)
        newReminderNotesCollectionView.register(priorityCollectionNib, forCellWithReuseIdentifier: "priorityIdentifier")
        
        let flagCollectionNib = UINib(nibName: "FlagCollectionViewCell", bundle: .main)
        newReminderNotesCollectionView.register(flagCollectionNib, forCellWithReuseIdentifier: "flagIdentifier")
        
    }
    
    func saveReminder() throws {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        do {
            try context.save()
            print("saved")
        } catch let error {
            throw(error)
        }
    }
    
    @objc func addNewReminder(){
        
        guard self.reminder?.title != ""  && self.reminder?.title != nil else {
            let alert = UIAlertController(title: "Error", message: "You have to fill the title", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            return
        }
        do {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let context = appDelegate.persistentContainer.viewContext
            let list = try context.fetch(List.fetchRequest()) as! [List]
          
            var tempList = List()
            var tempBool = false
            for item in list {
                if item.listText == listTitle{
                    tempBool = true
                    tempList = item
                    break
                }
            }
            if tempBool == true {
                reminder?.list = tempList
            } else {
                let databaseList = List(context: context)
                databaseList.listText = listTitle
                reminder?.list = databaseList
            }
            try saveReminder()
            print("saved")
        } catch {
            print("error")
        }
        
    }
    
    
}

extension NewReminderViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listArr[row].listText
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myNewList = listArr[row]
        
        
    }
    
}


extension NewReminderViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cellNewNotes = collectionView.dequeueReusableCell(withReuseIdentifier: "NewReminderNotesCollectionViewCell", for: indexPath) as! NewReminderNotesCollectionViewCell
            cellNewNotes.delegate = self
            return cellNewNotes
        }
        
        else if indexPath.item == 1 {
            let cellList = collectionView.dequeueReusableCell(withReuseIdentifier: "listIdentifier", for: indexPath) as! ListCollectionViewCell
            cellList.toolBar()
            cellList.source = self.listArr
            cellList.delegate = self
            return cellList
        }
        else if indexPath.item == 2 {
            let cellFlag = collectionView.dequeueReusableCell(withReuseIdentifier: "flagIdentifier", for: indexPath) as! FlagCollectionViewCell
            cellFlag.delegate = self
            return cellFlag
        }
        
        else {
            let cellPriority = collectionView.dequeueReusableCell(withReuseIdentifier: "priorityIdentifier", for: indexPath) as! PriorityCollectionViewCell
            cellPriority.toolPriorityBar()
            cellPriority.delegate = self
            return cellPriority
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

extension NewReminderViewController: MyDataSendingDelegateProtocol{
    func sendTitleDatatoViewController(titleTextField: String) {
        reminder?.title = titleTextField
    }
    
    func sendNotesDatatoViewController(notesTextField: String) {
        reminder?.notes = notesTextField
    }
    
}

extension NewReminderViewController:PriorityProtocolDelegate{
    func didSendPriority(priority: String) {
        reminder?.priority = priority
    }
}

extension NewReminderViewController:FlagProtocolDelegate {
    func flagDidChange(flag: Bool) {
        reminder?.flag = flag
    }
}

extension NewReminderViewController:SelectListDelegate{
    func didSelectList(listText: String) {
        self.listTitle = listText
    }
    
    
}

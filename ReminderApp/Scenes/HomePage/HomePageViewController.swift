//
//  ViewController.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 14.05.2021.
//

import UIKit
import CoreData

class HomePageViewController: UIViewController {

    @IBOutlet weak var mylistTableView: UITableView!
    
    @IBOutlet weak var mainCategoryCollectionView: UICollectionView!
    var listArr = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mylistTableView.delegate = self
        mylistTableView.dataSource = self
        mainCategoryCollectionView.delegate = self
        mainCategoryCollectionView.dataSource = self
        
        mylistTableView.layer.cornerRadius = 10
        mylistTableView.layer.masksToBounds = true
        
        let mainCategoryNib = UINib(nibName: "MainCategoryCollectionViewCell", bundle: .main)
        mainCategoryCollectionView.register(mainCategoryNib, forCellWithReuseIdentifier: "categoryIdentifier")
        
        let myListNib = UINib(nibName: "MyListTableViewCell", bundle: .main)
        mylistTableView.register(myListNib, forCellReuseIdentifier: "myListIdentifier")
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getList()
    }
    
    @IBAction func addlistButtonTapped(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddListViewController") as? AddListViewController {
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func newReminderButtonTapped(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NewReminderViewController") as? NewReminderViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func getList(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        do {
            let list = try context.fetch(List.fetchRequest()) as! [List]
            listArr = list
            mylistTableView.reloadData()
           
        } catch  {
            print("error")
        }
    }
    
}

func deleteItems(context: NSManagedObjectContext)  {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Reminder.fetchRequest()
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
    do {
        
        try context.execute(deleteRequest)
    } catch  {
        print("error")
    }
}

extension HomePageViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryIdentifier", for: indexPath) as! MainCategoryCollectionViewCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController{
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomePageViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "myListIdentifier", for: indexPath) as! MyListTableViewCell
        tableCell.reminderTextLabel.text = listArr[indexPath.row].listText
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
           let list =  listArr[indexPath.row]
            let reminders = list.reminders?.allObjects as! [Reminder]
            vc.titleAndNotes = reminders
            vc.isFromHome = true
            vc.listTitle = list.listText ?? ""
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}

extension HomePageViewController:AddListProtocolDelegate{
    func addListChangeTextField(addListTextField: String, addListImageView: Data) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let myList = List(context: context)
        myList.image =  addListImageView
        myList.listText = addListTextField
        listArr.append(myList)
        mylistTableView.reloadData()
    }
   
    
}

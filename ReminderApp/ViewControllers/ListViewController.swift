//
//  ListViewController.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 20.05.2021.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    
    @IBOutlet weak var allLable: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    var titleAndNotes :[Reminder]?
    var myList: List?
    var isFromHome: Bool = false
    var listTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        
        let emptyListNib = UINib(nibName: "EmptyListTableViewCell", bundle: .main)
        listTableView.register(emptyListNib, forCellReuseIdentifier: "emptyListIdentifier")
    }
    
    @IBAction func newReminderButtonTapped(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NewReminderViewController") as? NewReminderViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if isFromHome == false {
            self.allLable.text = "All"
            getTitleandNotes()
        } else {
            self.allLable.text = self.listTitle
            self.listTableView.reloadData()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
   
    func getTitleandNotes(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            self.titleAndNotes = try context.fetch(Reminder.fetchRequest())
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
    
        } catch  {
            print("error")
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
    
}


extension ListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleAndNotes?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emptyListIdentifier", for: indexPath) as! EmptyListTableViewCell
        cell.emptyListTextView.text = titleAndNotes?[indexPath.row].title
        return cell
    }
}

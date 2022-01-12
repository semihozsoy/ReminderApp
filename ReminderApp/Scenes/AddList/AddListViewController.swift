//
//  AddListViewController.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 14.05.2021.
//

import UIKit



class AddListViewController: UIViewController {

    @IBOutlet weak var addListCollectionView: UICollectionView!
    @IBOutlet weak var addListImage: UIImageView!
    @IBOutlet weak var addListTextField: UITextField!
    var listArr = [List]()
    var delegate: AddListProtocolDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addListCollectionView.delegate = self
        addListCollectionView.dataSource = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton))
        
        let addListNib = UINib(nibName: "AddListCollectionViewCell", bundle: .main)
        addListCollectionView.register(addListNib, forCellWithReuseIdentifier: "addListIdentifier")
        addListImage.layer.cornerRadius = 20
        addListImage.layer.masksToBounds = true
        
    }
    
    

    @objc func doneButton(){
        if self.delegate != nil && self.addListTextField.text != nil {
            let dataToBeSent = self.addListTextField.text!
            let dataImage = self.addListImage.image?.pngData()
            self.delegate?.addListChangeTextField(addListTextField: dataToBeSent, addListImageView: dataImage!)
                 
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        let context = appDelegate.persistentContainer.viewContext
      
        do {
            let myList = try context.fetch(List.fetchRequest()) as! [List]
            listArr = myList
            try context.save()

            if let vc = storyboard?.instantiateViewController(withIdentifier: "homePageVC") as? HomePageViewController {
                self.navigationController?.pushViewController(vc, animated: true)

            }
        } catch  {
            print("Kaydedilemedi")
        }

    }

    }
    
}

extension AddListViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var imagesArr = [UIImage]()
         (1...4).forEach{imagesArr.append(UIImage(named: "item\($0)")!)}
        imagesArr.append(UIImage(systemName: "list.bullet")!)
        return imagesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addListIdentifier", for: indexPath) as! AddListCollectionViewCell
        var imagesArr = [UIImage]()
         (1...4).forEach{imagesArr.append(UIImage(named: "item\($0)")!)}
        imagesArr.append(UIImage(systemName: "list.bullet")!)
        cell.imageView.image = imagesArr[indexPath.item]
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var imagesArr = [UIImage]()
         (1...4).forEach{imagesArr.append(UIImage(named: "item\($0)")!)}
        imagesArr.append(UIImage(systemName: "list.bullet")!)
        let selectedImage = imagesArr[indexPath.item]
            addListImage.image = selectedImage
    }

}

protocol AddListProtocolDelegate {
    func addListChangeTextField(addListTextField: String, addListImageView: Data)
    
}

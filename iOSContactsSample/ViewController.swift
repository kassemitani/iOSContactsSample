//
//  ViewController.swift
//  ContactsDVP
//
//  Created by Kassem Itani on 24/01/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var contactsList:[PhoneContact] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = contactsList[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: indexPath.row.description)
       
        cell.textLabel?.text = contact.fullName
        cell.detailTextLabel?.text = contact.number
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(
                    self, selector: #selector(contactStoreDidChange), name: .CNContactStoreDidChange, object: nil)
    }

    @IBAction func getContactList(_ sender: Any) {
        loadContactList()
    }
    
    func loadContactList() {
        ContactsManager.init().fetchAllContacts { (contacts, error) in
            print(contacts)
            self.contactsList = contacts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

   @objc func contactStoreDidChange(notification: NSNotification) {
        loadContactList()
   }
   
}

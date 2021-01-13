//
//  JournalListTableViewController.swift
//  Journal
//
//  Created by Benjamin Tincher on 1/12/21.
//

import UIKit

class JournalListTableViewController: UITableViewController {
    
    //  MARK: - IBOutlets
    @IBOutlet weak var journalTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JournalController.shared.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //  MARK: - IBActions
    @IBAction func createJournalButtonTapped(_ sender: Any) {
        guard let title = journalTitleTextField.text, !title.isEmpty else { return }
        JournalController.shared.createJournalWith(title: title)
        tableView.reloadData()
        journalTitleTextField.text = ""
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.shared.journals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        
        let journal = JournalController.shared.journals[indexPath.row]
        cell.textLabel?.text = journal.title
        cell.detailTextLabel?.text = "\(journal.entries.count)"

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let journal = JournalController.shared.journals[indexPath.row]
            JournalController.shared.deleteJournal(journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
  
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryListVC" {
            guard let index = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EntryListTableViewController else { return }
            let journal = JournalController.shared.journals[index.row]
            destination.journal = journal
        }
    }
}

//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Benjamin Tincher on 1/11/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    //  MARK: - Properties
    var journal: Journal?
    
    //  MARK: - Lifecyle functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        guard let journal = journal else { return cell }
        cell.textLabel?.text = journal.entries[indexPath.row].title
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let journal = journal else { return }
            journal.entries.remove(at: indexPath.row)
            
            //  Delete Row from tableView
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  IIDOO
        if segue.identifier == "toExistingEntryVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let journal = journal,
                  let destination = segue.destination as? EntryDetailViewController else { return }
            let entry = journal.entries[indexPath.row]
            destination.entry = entry
            destination.journal = journal
        }
    
        if segue.identifier == "toEntryVC" {
            guard let journal = journal,
                  let destination = segue.destination as? EntryDetailViewController else { return }
            destination.journal = journal
        }
    }
}

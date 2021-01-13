//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Benjamin Tincher on 1/11/21.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    //  MARK: Properties
    var journal: Journal?
    var entry: Entry?
    
    //  MARK: Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let entry = entry else { return }
        self.title = entry.timestamp
        updateView()
    }
    
    //  MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty,
              let journal = journal else { return }
        print(title)
        print(body)
        if let entry = entry {
            EntryController.updateEntryWith(title: title, body: body, entry: entry)
        } else {
            EntryController.createEntryWith(title: title, body: body, journal: journal)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    //  MARK: Update View
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
    func updateView() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
}

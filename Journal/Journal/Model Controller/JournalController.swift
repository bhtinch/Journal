//
//  JournalController.swift
//  Journal
//
//  Created by Benjamin Tincher on 1/12/21.
//

import Foundation

class JournalController {
    
    //  MARK: - Shared Instance
    static let shared = JournalController()
    
    //  MARK: - S.o.T.
    var journals:[Journal] = []
    
    //  MARK: - CRUD
    //  Create
    func createJournalWith(title: String){
        let journal = Journal(title: title)
        journals.append(journal)
        saveToPersistenceStore()
    }
    
    // Delete
    func deleteJournal(journal: Journal){
        guard let index = journals.firstIndex(of: journal) else { return }
        journals.remove(at: index)
        saveToPersistenceStore()
    }
    
    //  MARK: - Perisitence
    private func fileURL() -> URL {
     let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     let documentsDirectoryURL = urls[0].appendingPathComponent("Journals.json")
     return documentsDirectoryURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(journals)
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: fileURL())
            let journals = try JSONDecoder().decode([Journal].self, from: data)
            self.journals = journals
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

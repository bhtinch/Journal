//
//  EntryController.swift
//  Journal
//
//  Created by Benjamin Tincher on 1/11/21.
//

import Foundation

class EntryController {
        
    //  MARK: - C.R.U.D.
    static func createEntryWith(title: String, body: String, journal: Journal) {
        let entry = Entry(title: title, body: body)
        journal.entries.append(entry)
        JournalController.shared.saveToPersistenceStore()
    }
    
    static func updateEntryWith(title: String, body: String, entry: Entry) {
        let title = title
        let body = body
        let entry = entry
        entry.title = title
        entry.body = body
        JournalController.shared.saveToPersistenceStore()
    }
    
    static func delete(entry: Entry, journal: Journal) {
        
        guard let index = journal.entries.firstIndex(of: entry) else { return }
        journal.entries.remove(at: index)
        JournalController.shared.saveToPersistenceStore()
    }
}

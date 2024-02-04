//
//  NoteStorage.swift
//  notes
//
//  Created by Aleksandr Garipov on 02.02.2024.
//

import CoreData
import UIKit

class NoteStorage {
    static let shared = NoteStorage()
    
    private init() {}
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NoteCoreData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveNote(id: UUID = UUID(), title: String, text: NSAttributedString) {
        let note = NoteCoreDataModel(context: context)
        note.id = id
        note.title = title
        note.text = try? NSKeyedArchiver.archivedData(withRootObject: text, requiringSecureCoding: false)
        saveContext()
    }
    
    func updateNote(withId id: UUID, title: String, text: NSAttributedString) {
        let fetchRequest: NSFetchRequest<NoteCoreDataModel> = NoteCoreDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        if let noteToUpdate = try? context.fetch(fetchRequest).first {
            noteToUpdate.title = title
            noteToUpdate.text = try? NSKeyedArchiver.archivedData(withRootObject: text, requiringSecureCoding: false)
            saveContext()
        }
    }
    
    func fetchNotes() -> [NoteModel] {
        let fetchRequest: NSFetchRequest<NoteCoreDataModel> = NoteCoreDataModel.fetchRequest()
        do {
            let notes = try context.fetch(fetchRequest)
            return notes.compactMap { note in
                guard let title = note.title, let textData = note.text, let id = note.id else { return nil }
                do {
                    let text = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSAttributedString.self, from: textData)
                    return NoteModel(id: id, title: title, text: text ?? NSAttributedString())
                } catch {
                    print("Ошибка при разархивировании NSAttributedString: \(error)")
                    return nil
                }
            }
        } catch {
            print("Error fetching notes: \(error)")
            return []
        }
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


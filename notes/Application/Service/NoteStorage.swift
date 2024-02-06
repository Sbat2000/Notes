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
    
    func saveOrUpdateNote(_ noteModel: NoteModel) {
        let fetchRequest: NSFetchRequest<NoteCoreDataModel> = NoteCoreDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", noteModel.id as CVarArg)
        do {
            let results = try context.fetch(fetchRequest)
            let note: NoteCoreDataModel

            if let existingNote = results.first {
                note = existingNote
            } else {
                note = NoteCoreDataModel(context: context)
                note.id = noteModel.id
            }
            note.title = noteModel.title
            note.text = try NSKeyedArchiver.archivedData(withRootObject: noteModel.text, requiringSecureCoding: true)
            try context.save()
        } catch {
            print("Ошибка при сохранении или обновлении заметки: \(error)")
        }
    }
    
    func deleteNote(_ noteModel: NoteModel) {
        let fetchRequest: NSFetchRequest<NoteCoreDataModel> = NoteCoreDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", noteModel.id as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if let noteToDelete = results.first {
                context.delete(noteToDelete)
                try context.save()
                print("Заметка успешно удалена.")
            } else {
                print("Заметка с указанным ID не найдена.")
            }
        } catch {
            print("Ошибка при удалении заметки: \(error)")
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


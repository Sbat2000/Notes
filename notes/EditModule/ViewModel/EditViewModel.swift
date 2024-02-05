//
//  EditViewModel.swift
//  notes
//
//  Created by Aleksandr Garipov on 01.02.2024.
//

import UIKit

protocol EditViewModelDelegate: AnyObject {
    func saveOrUpdateNote(note: NoteModel)
}

final class EditViewModel {
    private var noteForEditing: NoteModel
    private var editedTitle: String
    private var editedText: NSAttributedString
    private let editViewControllerCoordinator: EditViewControllerCoordinator
    private weak var delegate: EditViewModelDelegate?
    
    @Observable
    private (set) var currentNoteModel: NoteModel?
    
    init(noteModelFromDB: NoteModel, editViewControllerCoordinator: EditViewControllerCoordinator, delegate: EditViewModelDelegate) {
        self.noteForEditing = noteModelFromDB
        self.editViewControllerCoordinator = editViewControllerCoordinator
        self.delegate = delegate
        self.editedTitle = noteModelFromDB.title
        self.editedText = noteModelFromDB.text
    }
    
    deinit {
        print("Deinited \(self)")
    }
    
    func viewWillAppear() {
        currentNoteModel = noteForEditing
    }
    
    func saveButtonPressed() {
        let newNote = NoteModel(id: noteForEditing.id, title: editedTitle, text: editedText)
        delegate?.saveOrUpdateNote(note: newNote)
        editViewControllerCoordinator.finish()
    }
    
    func cancelButtonPressed() {
        editViewControllerCoordinator.finish()
    }
    
    func updateTitle(_ title: String) {
        self.editedTitle = title
    }

    func updateText(_ text: NSAttributedString) {
        self.editedText = text
    }
}

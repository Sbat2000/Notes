//
//  NoteViewModel.swift
//  notes
//
//  Created by Aleksandr Garipov on 31.01.2024.
//

import UIKit

final class NoteViewModel {
    
    private var noteModelFromDB: NoteModel
    private let noteViewControllerCoordinator: NoteViewControllerCoordinator
    
    @Observable
    private (set) var currentNoteModel: NoteModel?
    
    init(noteModelFromDB: NoteModel, noteViewControllerCoordinator: NoteViewControllerCoordinator) {
        self.noteModelFromDB = noteModelFromDB
        self.noteViewControllerCoordinator = noteViewControllerCoordinator
    }
    
    func viewWillAppear() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.currentNoteModel = self.noteModelFromDB
        }
    }
    
    func editButtonTapped() {
        noteViewControllerCoordinator.goToEdit(note: currentNoteModel ?? noteModelFromDB, delegate: self)
    }
    
    deinit {
        print("Deinited \(self)")
    }
}

//MARK: - EditViewModelDelegate

extension NoteViewModel: EditViewModelDelegate {
    func saveOrUpdateNote(note: NoteModel) {
        self.currentNoteModel = note
        NoteStorage.shared.saveOrUpdateNote(note)
    }
}

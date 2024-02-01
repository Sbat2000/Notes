//
//  EditViewModel.swift
//  notes
//
//  Created by Aleksandr Garipov on 01.02.2024.
//

import UIKit

final class EditViewModel {
    private var noteForEditing: NoteModel
    private let editViewControllerCoordinator: EditViewControllerCoordinator
    
    @Observable
    private (set) var currentNoteModel: NoteModel?
    
    init(noteModelFromDB: NoteModel, editViewControllerCoordinator: EditViewControllerCoordinator) {
        self.noteForEditing = noteModelFromDB
        self.editViewControllerCoordinator = editViewControllerCoordinator
    }
    
    func viewWillAppear() {
        currentNoteModel = noteForEditing
    }
    
    func cancelButtonPressed() {
        editViewControllerCoordinator.finish()
    }
}

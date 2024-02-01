//
//  EditViewModel.swift
//  notes
//
//  Created by Aleksandr Garipov on 01.02.2024.
//

import UIKit

final class EditViewModel {
    private var noteForEditing: NoteModel
    weak var editViewControllerCoordinator: EditViewControllerCoordinator?
    
    @Observable
    private (set) var currentNoteModel: NoteModel?
    
    init(noteModelFromDB: NoteModel) {
        self.noteForEditing = noteModelFromDB
    }
    
    func viewWillAppear() {
        currentNoteModel = noteForEditing
        
    }
}

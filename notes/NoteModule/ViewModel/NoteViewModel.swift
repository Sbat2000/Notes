//
//  NoteViewModel.swift
//  notes
//
//  Created by Aleksandr Garipov on 31.01.2024.
//

import UIKit

final class NoteViewModel {
    private var noteModelFromDB: NoteModel
    
    var isEditing = false
    
    @Observable
    private (set) var currentNoteModel: NoteModel?
    
    init(noteModelFromDB: NoteModel) {
        self.noteModelFromDB = noteModelFromDB
    }
    
    func viewWillAppear() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.currentNoteModel = self.noteModelFromDB
        }
    }
}

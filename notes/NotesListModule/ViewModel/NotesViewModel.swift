//
//  NotesViewModel.swift
//  notes
//
//  Created by Aleksandr Garipov on 31.01.2024.
//

import Foundation

protocol NotesViewModelProtocol {
    var numberOfNotes: Int { get }
    func viewWillAppear()
}

final class NotesViewModel {
    
    weak var notesViewControllerCoordinator: NotesViewControllerCoordinator?
    
    @Observable
    private (set) var listOfNotes: [NoteModel] = []
    
    func viewWillAppear() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.listOfNotes.append(NoteModel(title: "Проверка", text: "Это первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\nЭто первая заметка, это первая заметка\n"))
        }
    }
    
    func didTapCell(indexPath: IndexPath) {
        let note = listOfNotes[indexPath.row]
        notesViewControllerCoordinator?.goToNoteViewController(note: note)
    }
}
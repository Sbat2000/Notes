//
//  NotesViewModel.swift
//  notes
//
//  Created by Aleksandr Garipov on 31.01.2024.
//

import UIKit

final class NotesViewModel {
    
    //MARK: - Properties
    
    weak var notesViewControllerCoordinator: NotesViewControllerCoordinator?
    
    @Observable
    private (set) var listOfNotes: [NoteModel] = []
    
    //MARK: - Methods
    
    func viewWillAppear() {
        fetchNotes()
    }
    
    func didTapCell(indexPath: IndexPath) {
        let note = listOfNotes[indexPath.row]
        notesViewControllerCoordinator?.goToNoteViewController(note: note)
    }
    
    func addButtonTapped() {
        let note = NoteModel(title: "Заметка", text: NSAttributedString(string: "Текст заметки"))
        notesViewControllerCoordinator?.goToEdit(note: note, delegate: self)
    }
    
    func didSwipeToDelete(at indexPath: IndexPath) {
        let note = listOfNotes[indexPath.row]
        NoteStorage.shared.deleteNote(note)
        self.fetchNotes()
    }
    
    private func fetchNotes() {
        let notes = NoteStorage.shared.fetchNotes()
        if notes.isEmpty {
            createFirstNote()
        }
        let updatedNotes = NoteStorage.shared.fetchNotes()
        self.listOfNotes = updatedNotes
    }
    
    private func createFirstNote() {
        let text = "Это первая заметка, это первая заметка"
        let attributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        
        let boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        let italicAttribute = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16)]
        
        if let firstSpaceRange = text.range(of: " "), let lastSpaceRange = text.range(of: " ", options: .backwards) {
            let boldRange = NSRange(text.startIndex..<firstSpaceRange.lowerBound, in: text)
            let italicRange = NSRange(lastSpaceRange.upperBound..<text.endIndex, in: text)
            
            attributedString.addAttributes(boldAttribute, range: boldRange)
            attributedString.addAttributes(italicAttribute, range: italicRange)
        }
        let note = NoteModel(title: "Первая заметка", text: attributedString)
        NoteStorage.shared.saveOrUpdateNote(note)
    }
}

//MARK: - EditViewModelDelegate

extension NotesViewModel: EditViewModelDelegate {
    func saveOrUpdateNote(note: NoteModel) {
        NoteStorage.shared.saveOrUpdateNote(note)
        self.fetchNotes()
    }
}

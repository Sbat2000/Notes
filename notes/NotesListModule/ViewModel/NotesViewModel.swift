//
//  NotesViewModel.swift
//  notes
//
//  Created by Aleksandr Garipov on 31.01.2024.
//

import UIKit

protocol NotesViewModelProtocol {
    var numberOfNotes: Int { get }
    func viewWillAppear()
}

final class NotesViewModel {
    
    weak var notesViewControllerCoordinator: NotesViewControllerCoordinator?
    
    @Observable
    private (set) var listOfNotes: [NoteModel] = []
    
    func viewWillAppear() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
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
            
            let note = NoteModel(id: UUID(), title: "Проверка", text: attributedString)
            
            self.listOfNotes.append(note)
        }
    }
    
    func didTapCell(indexPath: IndexPath) {
        let note = listOfNotes[indexPath.row]
        notesViewControllerCoordinator?.goToNoteViewController(note: note)
    }
    
    private func fetchNotes() {
        let notes = NoteStorage.shared.fetchNotes()
//        if notes.isEmpty {
//            //createFirstNote()
//        }
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
        NoteStorage.shared.saveNote(title: "Проверка", text: attributedString)
    }
}

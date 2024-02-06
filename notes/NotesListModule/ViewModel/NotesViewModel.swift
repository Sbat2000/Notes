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
        let image = UIImage(resource: .sobaka)
        
        let textAttachment = NSTextAttachment()
        textAttachment.image = image.resized(toWidth: 300)
        let imageString = NSAttributedString(attachment: textAttachment)
        
        let completeText = NSMutableAttributedString()
        completeText.append(NSAttributedString(string: "Тут можно писать курсивом, писать жирным, вставлять картинку, например моей собаки, которая не успела убежать:\n"))
        completeText.append(imageString)
        completeText.append(NSAttributedString(string: "\nА также редактировать и удалять (с помощью свайпа влево ячейки таблицы) заметки"))
        
        if let italicRange = completeText.string.range(of: "курсивом") {
            completeText.addAttributes([.font: UIFont.italicSystemFont(ofSize: 16)], range: NSRange(italicRange, in: completeText.string))
        }
        if let boldRange = completeText.string.range(of: "жирным") {
            completeText.addAttributes([.font: UIFont.boldSystemFont(ofSize: 16)], range: NSRange(boldRange, in: completeText.string))
        }
        
        let note = NoteModel(title: "Первая заметка", text: completeText)
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

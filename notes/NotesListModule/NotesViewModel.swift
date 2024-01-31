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

final class NotesViewModel: NotesViewModelProtocol {
    
    @Observable
    private (set) var numberOfNotes = 0
    
    func viewWillAppear() {
        numberOfNotes = 2
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.numberOfNotes = 5
        }
    }
}

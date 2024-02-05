//
//  NoteModel.swift
//  notes
//
//  Created by Aleksandr Garipov on 31.01.2024.
//

import Foundation

struct NoteModel {
    let id: UUID
    let title: String
    let text: NSAttributedString
    
    init(id: UUID? = nil, title: String, text: NSAttributedString) {
        self.id = id ?? UUID()
        self.title = title
        self.text = text
    }
}

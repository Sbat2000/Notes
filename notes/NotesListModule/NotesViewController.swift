//
//  ViewController.swift
//  notes
//
//  Created by Aleksandr Garipov on 30.01.2024.
//

import UIKit

class NotesViewController: UIViewController {
    
    weak var notesViewControllerCoordinator: NotesViewControllerCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Notes"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]

    }
}


//
//  NoteViewControllerCoordinator.swift
//  notes
//
//  Created by Aleksandr Garipov on 31.01.2024.
//

import UIKit

final class NoteViewControllerCoordinator: BaseCoordinator {
    
    private var navigationController: UINavigationController
    private let note: NoteModel
    var appCoordinator: AppCoordinator
    
    init(navigationController: UINavigationController, appCoordinator: AppCoordinator, note: NoteModel) {
        self.navigationController = navigationController
        self.appCoordinator = appCoordinator
        self.note = note
    }
    
    override func start() {
        let viewModel = NoteViewModel(noteModelFromDB: note)
        let noteViewController = NoteViewController(viewModel: viewModel)
        noteViewController.noteViewControllerCoordinator = self
        navigationController.pushViewController(noteViewController, animated: true)
    }
}

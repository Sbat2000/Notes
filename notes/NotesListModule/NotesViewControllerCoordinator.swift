//
//  NotesViewControllerCoordinator.swift
//  notes
//
//  Created by Aleksandr Garipov on 30.01.2024.
//

import UIKit

final class NotesViewControllerCoordinator: BaseCoordinator {
    
    private var navigationController: UINavigationController
    var appCoordinator: AppCoordinator
    
    
    init(navigationController: UINavigationController, appCoordinator: AppCoordinator) {
        self.navigationController = navigationController
        self.appCoordinator = appCoordinator
    }
    
    override func start() {
        let notesViewController = NotesViewController()
        let viewModel = NotesViewModel()
        viewModel.notesViewControllerCoordinator = self
        notesViewController.viewModel = viewModel
        navigationController.pushViewController(notesViewController, animated: true)
    }
    
    func goToNoteViewController(note: NoteModel) {
        let noteViewControllerCoordinator = NoteViewControllerCoordinator(navigationController: navigationController, appCoordinator: appCoordinator, note: note)
        noteViewControllerCoordinator.start()
    }
    
    func goToEdit(note: NoteModel, delegate: EditViewModelDelegate) {
        let editViewControllerCoordinator = EditViewControllerCoordinator(navigationController: navigationController, appCoordinator: appCoordinator, note: note, delegate: delegate)
        editViewControllerCoordinator.start()
    }
}

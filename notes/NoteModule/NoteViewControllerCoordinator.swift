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
        let viewModel = NoteViewModel(noteModelFromDB: note, noteViewControllerCoordinator: self)
        let noteViewController = NoteViewController(viewModel: viewModel)
        navigationController.pushViewController(noteViewController, animated: true)
    }
    
    func goToEdit(note: NoteModel) {
        let editViewControllerCoordinator = EditViewControllerCoordinator(navigationController: navigationController, appCoordinator: appCoordinator, note: note)
        editViewControllerCoordinator.start()
    }
}

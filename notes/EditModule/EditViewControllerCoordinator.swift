//
//  EditViewControllerCoordinator.swift
//  notes
//
//  Created by Aleksandr Garipov on 01.02.2024.
//

import UIKit

final class EditViewControllerCoordinator: BaseCoordinator {
    
    private var navigationController: UINavigationController
    private let note: NoteModel
    var appCoordinator: AppCoordinator
    private let delegate: EditViewModelDelegate
    
    
    init(navigationController: UINavigationController, appCoordinator: AppCoordinator, note: NoteModel, delegate: EditViewModelDelegate) {
        self.navigationController = navigationController
        self.appCoordinator = appCoordinator
        self.note = note
        self.delegate = delegate
    }
    
    override func start() {
        let viewModel = EditViewModel(noteModelFromDB: note, editViewControllerCoordinator: self, delegate: delegate)
        let editViewController = EditViewController(viewModel: viewModel)
        navigationController.pushViewController(editViewController, animated: true)
    }
    
    func finish() {
        navigationController.popViewController(animated: true)
    }
}

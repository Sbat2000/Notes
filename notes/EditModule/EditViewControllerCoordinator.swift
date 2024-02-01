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
    
    init(navigationController: UINavigationController, appCoordinator: AppCoordinator, note: NoteModel) {
        self.navigationController = navigationController
        self.appCoordinator = appCoordinator
        self.note = note
    }
    
    override func start() {
        let viewModel = EditViewModel(noteModelFromDB: note)
        viewModel.editViewControllerCoordinator = self
        let editViewController = EditViewController(viewModel: viewModel)
        navigationController.pushViewController(editViewController, animated: true)
    }
}

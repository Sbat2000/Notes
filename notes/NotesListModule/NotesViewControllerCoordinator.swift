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
        notesViewController.viewModel = viewModel
        notesViewController.notesViewControllerCoordinator = self
        navigationController.pushViewController(notesViewController, animated: true)
    }
}

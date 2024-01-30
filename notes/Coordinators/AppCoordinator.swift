//
//  AppCoordinator.swift
//  notes
//
//  Created by Aleksandr Garipov on 30.01.2024.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    private var window: UIWindow
    
    private var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    override func start() {
        let notesViewControllerCoordinator = NotesViewControllerCoordinator(navigationController: navigationController, appCoordinator: self)
        add(coordinator: notesViewControllerCoordinator)
        notesViewControllerCoordinator.start()
    }
}

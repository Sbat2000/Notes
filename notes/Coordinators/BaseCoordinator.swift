//
//  BaseCoordinator.swift
//  notes
//
//  Created by Aleksandr Garipov on 30.01.2024.
//

import Foundation

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    func start() {
        fatalError("Child should implement funcStart")
    }
}

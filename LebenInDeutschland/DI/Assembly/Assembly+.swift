//
//  Assembly+.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 18.05.23.
//

import Foundation
import Swinject

// Modularized registration of dependencies
// If this file grows so big, we can separate the [Assembly]'s into different files within the Assembly folder
// See https://github.com/Swinject/Swinject/blob/master/Documentation/Assembler.md
// Supported registration scopes https://github.com/Swinject/Swinject/blob/master/Documentation/ObjectScopes.md

// MARK: - all managers should be registered here
class ManagerAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        
    }
}

// MARK: - All Services will be registered here
class ServiceAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(QuestionService.self) { _ in
            return QuestionServiceImpl()
        }
        
        container.register(CategoryService.self) { _ in
            return CategoryServiceImpl()
        }
    }
}

// MARK: - All repositories will be registered
class RepositoryAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        
    }
}

// MARK: - All utilities will be registered here
class UtilityAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        
    }
}

// MARK: - All ViewModels
/// All ViewModels are registered here i.e. a factory to get a new instance for every time one is needed
class ViewModelAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        
        container.register(CategoryListViewModel.self) { r in
            return CategoryListViewModel(r.resolve(CategoryService.self)!)
        }
        
        container.register(CategoryDetailViewModel.self) { r, c in
            return CategoryDetailViewModel(category: c, r.resolve(QuestionService.self)!)
        }
    }
}

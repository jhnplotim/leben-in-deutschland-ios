//
//  CategoryListViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 15.05.23.
//

import Foundation

final class CategoryListViewModel: ObservableObject {
    
    @Published var categories: [CategoryModel]
    
    init(_ service: some CategoryService) {
        // TODO: Load categories from data storage
        self.categories = service.getCategories()
    }
    
}

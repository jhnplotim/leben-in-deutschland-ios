//
//  CategoryServiceImpl.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 15.05.23.
//

import Foundation

final class CategoryServiceImpl: CategoryService {
    
    enum C {
        static let jsonFile = "categories.json"
    }
    
    private var categories: [CategoryModel]
    
    init() {
        categories = load(C.jsonFile)
    }
    
    func getCategories() -> [CategoryModel] {
        categories
    }
}

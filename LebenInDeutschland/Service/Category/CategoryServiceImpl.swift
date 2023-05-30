//
//  CategoryServiceImpl.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 15.05.23.
//

import Foundation

final class CategoryServiceImpl: CategoryService {
    
    private var categories: [PracticeCategory]
    
    init() {
        categories = PracticeCategory.allCases
    }
    
    func getCategories() -> [PracticeCategory] {
        categories
    }
}

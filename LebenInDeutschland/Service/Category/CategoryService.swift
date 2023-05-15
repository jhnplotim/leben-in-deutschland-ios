//
//  CategoryService.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 15.05.23.
//

import Foundation

protocol CategoryService: AnyObject {
    func getCategories() -> [CategoryModel]
}

//
//  StateListService.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 19.05.23.
//

import Foundation

protocol StateListService {
    func getAll() -> [StateModel]
}

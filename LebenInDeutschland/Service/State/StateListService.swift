//
//  StateListService.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 19.05.23.
//

import Foundation

// TODO: Implement storage of selected state within the StateListService & expose it via a publisher (also, make singleton)
protocol StateListService {
    func getAll() -> [StateModel]
}

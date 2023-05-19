//
//  StateListServiceImpl.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 19.05.23.
//

import Foundation

final class StateListServiceImpl: StateListService {
    enum C {
        static let jsonFile = "states.json"
    }
    
    private var allStates: [StateModel]
    
    init() {
        allStates = load(C.jsonFile)
    }
    
    func getAll() -> [StateModel] {
        allStates
    }
    
}

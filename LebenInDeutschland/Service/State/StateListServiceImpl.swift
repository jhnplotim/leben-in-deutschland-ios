//
//  StateListServiceImpl.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 19.05.23.
//

import Foundation

final class StateListServiceImpl: StateListService {
    private var allStates: [StateModel]
    
    init() {
        allStates = FederalState.allValidCases.map { $0.dataModel }
    }
    
    func getAll() -> [StateModel] {
        allStates
    }
    
}

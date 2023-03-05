//
//  ErrorWrapper.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 05.03.23.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
    
}

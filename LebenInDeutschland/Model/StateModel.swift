//
//  State.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import Foundation
import SwiftUI

struct StateModel: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var info: String
    
    private var imageName: String {
        id
    }
    
    var image: Image {
        Image(imageName)
    }
    
    
}

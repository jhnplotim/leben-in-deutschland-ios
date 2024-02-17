//
//  Assembler+.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 18.05.23.
//

import Foundation
import Swinject

// See https://github.com/Swinject/Swinject/blob/master/Documentation/Assembler.md
extension Assembler {
	static let container: Container = {
		Container()
	}()
	
    static let sharedAssembler: Assembler = {
        let assembler = Assembler([
            ManagerAssembly(),
            UtilityAssembly(),
            ServiceAssembly(),
            RepositoryAssembly(),
            ViewModelAssembly()
        ], container: container)
        
        return assembler
    }()
}

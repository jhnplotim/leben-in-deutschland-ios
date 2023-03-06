//
//  StatisticsManager.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 06.03.23.
//

import Foundation

final class StatisticsManager: ObservableObject {
    @Published private(set) var chosenAnswers: [ChosenAnswer] = []
    
}

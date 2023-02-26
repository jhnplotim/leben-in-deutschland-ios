//
//  ModelData.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI
import Combine

final class ModelData: ObservableObject {
    var states: [StateModel] = load("states.json")
    
    var allQuestions: [QuestionModel] = load("questions.json")
    
    var allStateQuestions: [QuestionModel] {
        allQuestions.filter({ $0.stateId != nil })
    }
    
    var selectedStateQuestions: [QuestionModel] {
        allStateQuestions
        // TODO: Filter out based on selected state
    }
    
    var generalQuestions: [QuestionModel] {
        allQuestions.filter({ $0.stateId == nil })
    }
    
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle: \n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

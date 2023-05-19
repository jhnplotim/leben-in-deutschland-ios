//
//  StateDetailViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 19.05.23.
//

import Foundation

final class StateDetailViewModel: ObservableObject {
    @Published var state: StateModel
    
    @Published var assessmentToShow: AssessmentType?
    
    init(stateToView: StateModel) {
        state = stateToView
    }
    
    func showExam() {
        #if DEBUG
        assessmentToShow = .exam(stateId: state.id, generalCount: 10, stateCount: 2)
        #else
        assessmentToShow = .exam(stateId: state.id)
        #endif
    }
    
    func showStateOnlyAssessment() {
        #if DEBUG
        assessmentToShow = .state(stateId: state.id, count: 5)
        #else
        assessmentToShow = .state(stateId: state.id)
        #endif
    }
}

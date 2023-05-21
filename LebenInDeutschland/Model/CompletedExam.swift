//
//  CompletedExam.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 06.03.23.
//

import Foundation

struct CompletedExam: Identifiable, Hashable, Equatable, Codable {
    let id: Int
    let stateId: String
    let questionCount: Int
    let questionCountAnsweredCorrectly: Int
    let questionCountAnsweredWrongly: Int
    let questionCountUnanswered: Int
    let dateTimeStarted: Date
    let dateTimeEnded: Date
}

//
//  CompletedExam.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 06.03.23.
//

import Foundation

struct CompletedExam: Identifiable, Hashable, Equatable, Codable, Comparable {
    static func < (lhs: CompletedExam, rhs: CompletedExam) -> Bool {
        lhs.dateTimeEnded > rhs.dateTimeEnded
    }
    
    let id: Int
    let stateId: Int
    let questionCount: Int
    let questionCountAnsweredCorrectly: Int
    let questionCountAnsweredWrongly: Int
    let questionCountUnanswered: Int
    let dateTimeStarted: Date
    let dateTimeEnded: Date
    let passmarkUsed: Double
}

extension CompletedExam {
    var score: CGFloat {
        Double(questionCountAnsweredCorrectly) / Double(questionCount)
    }
    var passed: Bool {
        score >= passmarkUsed
    }
}

//
//  AssessmentSummary.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 19.05.23.
//

import Foundation

struct AssessmentSummary: Hashable, Equatable, CustomStringConvertible {
    var questionCount: Int
    var questionCountAnsweredCorrectly: Int
    var questionCountAnsweredWrongly: Int
    var questionCountUnanswered: Int

    var progress: CGFloat {
        CGFloat(questionCount - questionCountUnanswered) / CGFloat(questionCount)
    }

    var description: String {
            return "AssessmentSummary { \n QN Count: \(questionCount), \n CORRECT: \(questionCountAnsweredCorrectly), \n WRONG: \(questionCountAnsweredWrongly), \n UNANSWERED: \(questionCountUnanswered) \n }"
        }

    var score: CGFloat {
        Double(questionCountAnsweredCorrectly) / Double(questionCount)
    }
    var passed: Bool {
        score >= GlobalC.PASSMARK
    }

    static let `none` = AssessmentSummary(questionCount: 0, questionCountAnsweredCorrectly: 0, questionCountAnsweredWrongly: 0, questionCountUnanswered: 0)
}

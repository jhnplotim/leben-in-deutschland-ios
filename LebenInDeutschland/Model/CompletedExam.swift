//
//  CompletedExam.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 06.03.23.
//

import Foundation

struct CompletedExam {
    let id: Int
    let questionCount: Int
    let questionCountAnsweredCorrectly: Int
    let questionCountAnsweredWrongly: Int
    let questionCountUnanswered: Int
    let dateTimeStarted: Date
    let dateTimeEnded: Date
}

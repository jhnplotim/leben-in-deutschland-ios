//
//  QuestionModel+.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 22.05.23.
//

import Foundation

extension Array where Element == QuestionModel {
    func getRowModels(attemptMgr: AttemptManager) -> [QuestionRow.Model] {
        self.map {
            $0.getRowModel(attemptMgr: attemptMgr)
        }
    }
}

extension QuestionModel {
    func getRowModel(attemptMgr: AttemptManager) -> QuestionRow.Model {
        .init(id: self.id, title: self.title, answerHistory: attemptMgr.getChosenAnswers(for: self.id).map { $0.wasCorrect ?? false })
    }
}

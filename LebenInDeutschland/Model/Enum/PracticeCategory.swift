//
//  PracticeCategory.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 30.05.23.
//

import Foundation

// Use GooglePlaystore LID Android app to get recent categories to be included.
enum PracticeCategory: Int, Codable, CaseIterable, Identifiable {
	case politikInDerDemokratie = 1
	case geschichteUndVerantwortung = 2
	case menschUndGesellschaft = 3
    
    var id: Int {
        rawValue
    }
}

extension PracticeCategory {
    func getModel(with qnIds: [Int] = []) -> CategoryModel {
		switch self {
		case .politikInDerDemokratie:
			return .init(id: id, name: "Politik in der Demokratie", qnIds: qnIds)
			
		case .geschichteUndVerantwortung:
			return .init(id: id, name: "Geschichte und Verantwortung", qnIds: qnIds)
			
		case .menschUndGesellschaft:
			return .init(id: id, name: "Mensch und Gesellschaft", qnIds: qnIds)
		}
    }
}

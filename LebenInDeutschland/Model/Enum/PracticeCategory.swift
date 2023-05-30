//
//  PracticeCategory.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 30.05.23.
//

import Foundation

enum PracticeCategory: Int, Codable, CaseIterable, Identifiable {
    case deutschlandUndDieDeutschen = 1
    case grundlinienDeutscherGeschichte = 2
    case verfassungUndGrundrechte = 3
    case wahlenParteienUndInteressenverbände = 4
    case parlamentRegierungUndStreitkräfte = 5
    case bundesstaatRechtsstaatUndSozialstaat = 6
    case deutschlandInEuropa = 7
    case kulturUndWissenschaft = 8
    case deutscheNationalsymbole = 9
    
    var id: Int {
        rawValue
    }
}

extension PracticeCategory {
    func getModel(with qnIds: [Int] = []) -> CategoryModel {
        switch self {
        case .deutschlandUndDieDeutschen:
            return .init(id: id, name: "Deutschland und die Deutschen", qnIds: qnIds)
            
        case .grundlinienDeutscherGeschichte:
            return .init(id: id, name: "Grundlinien deutscher Geschichte", qnIds: qnIds)
            
        case .verfassungUndGrundrechte:
            return .init(id: id, name: "Verfassung und Grundrechte", qnIds: qnIds)
            
        case .wahlenParteienUndInteressenverbände:
            return .init(id: id, name: "Wahlen, Parteien und Interessenverbände", qnIds: qnIds)
            
        case .parlamentRegierungUndStreitkräfte:
            return .init(id: id, name: "Parlament, Regierung und Streitkräfte", qnIds: qnIds)
            
        case .bundesstaatRechtsstaatUndSozialstaat:
            return .init(id: id, name: "Bundesstaat, Rechtsstaat und Sozialstaat", qnIds: qnIds)
            
        case .deutschlandInEuropa:
            return .init(id: id, name: "Deutschland in Europa", qnIds: qnIds)
            
        case .kulturUndWissenschaft:
            return .init(id: id, name: "Kultur und Wissenschaft", qnIds: qnIds)
            
        case .deutscheNationalsymbole:
            return .init(id: id, name: "Deutsche Nationalsymbole", qnIds: qnIds)
        }
    }
}

//
//  Bundesland.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.05.23.
//

import Foundation

/// List federal states in Germany
enum FederalState: Int, Codable, Identifiable, CaseIterable, Equatable {
    case noneSelected = -1
    case badenWürttemberg = 1
    case bayern = 2
    case berlin = 3
    case brandenburg = 4
    case bremen = 5
    case hamburg = 6
    case hessen = 7
    case mecklenburgVorpommern = 8
    case niedersachsen = 9
    case nordrheinWestfalen = 10
    case rheinlandPfalz = 11
    case saarland = 12
    case sachsen = 13
    case sachsenAnhalt = 14
    case schleswigHolstein = 15
    case thüringen = 16
    
    var id: Int {
        self.rawValue
    }
    
    static var allValidCases: [FederalState] {
        allCases.filter { $0 != .noneSelected }
    }
}

extension FederalState {
    var dataModel: StateModel {
        switch self {
            
        case .noneSelected:
            return .init(id: self.id, code: "noneSelected", name: "None Selected", info: "No Residence State selected")
            
        case .bayern:
            return .init(id: self.id, code: "by", name: "Bayern", info: "Der Freistaat ist mit 70.550 km² das größte Bundesland")
            
        case .badenWürttemberg:
            return .init(id: self.id, code: "bw", name: "Baden-Württemberg", info: "Das Ländle, 35.751 km² groß")
            
        case .berlin:
            return .init(id: self.id, code: "be", name: "Berlin", info: "Die Hauptstadt der Bundesrepublik Deutschland")
            
        case .brandenburg:
            return .init(id: self.id, code: "bb", name: "Brandenburg", info: "Reich an Naturparks, Wäldern, Seen und Wassergebieten")
            
        case .bremen:
            return .init(id: self.id, code: "hb", name: "Bremen", info: "Zwei-Städte-Staat an der Weser")
            
        case .hamburg:
            return .init(id: self.id, code: "hh", name: "Hamburg", info: "Stadtstaat und zweitgrößte Stadt Deutschlands")
            
        case .hessen:
            return .init(id: self.id, code: "he", name: "Hessen", info: "Eine der am dichtesten besiedelten Regionen Deutschlands")
            
        case .mecklenburgVorpommern:
            return .init(id: self.id, code: "mv", name: "Mecklenburg-Vorpommern", info: "Wasserreiches Land an der Ostsee mit ca. 2000 km Küstenlinie")
            
        case .niedersachsen:
            return .init(id: self.id, code: "ni", name: "Niedersachsen", info: "Das flächenmäßig zweitgrößte Bundesland")
            
        case .nordrheinWestfalen:
            return .init(id: self.id, code: "nw", name: "Nordrhein-Westfalen", info: "Mit 17,9 Mio. das bevölkerungsreichste Bundesland")
            
        case .rheinlandPfalz:
            return .init(id: self.id, code: "rp", name: "Rheinland-Pfalz", info: "Ein junges Land auf historischem Boden")
            
        case .saarland:
            return .init(id: self.id, code: "sl", name: "Saarland", info: "Das kleinste Flächenland Deutschlands")
            
        case .sachsen:
            return .init(id: self.id, code: "sn", name: "Sachsen", info: "Freistaat Sachsen")
            
        case .sachsenAnhalt:
            return .init(id: self.id, code: "st", name: "Sachsen-Anhalt", info: "Bundesland mit der höchsten Dichte an UNESCO-Weltkulturerben in Deutschland")
            
        case .schleswigHolstein:
            return .init(id: self.id, code: "sh", name: "Schleswig-Holstein", info: "Das Land zwischen der Nord- und Ostsee")
            
        case .thüringen:
            return .init(id: self.id, code: "th", name: "Thüringen", info: "Freistaat Thüringen")
            
        }
    }
}

extension StateModel {
    var federalState: FederalState {
        return FederalState(rawValue: self.id) ?? .noneSelected
    }
}

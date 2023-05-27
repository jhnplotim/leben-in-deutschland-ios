//
//  Bundesland.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.05.23.
//

import Foundation

/// List federal states in Germany
enum FederalState: String, Identifiable, CaseIterable, Codable {
    case noneSelected = "noneSelected"
    case bayern = "by"
    case badenWürttemberg = "bw"
    case berlin = "be"
    case brandenburg = "bb"
    case bremen = "hb"
    case hamburg = "hh"
    case hessen = "he"
    case mecklenburgVorpommern = "mv"
    case niedersachsen = "ni"
    case nordrheinWestfalen = "nw"
    case rheinlandPfalz = "rp"
    case saarland = "sl"
    case sachsen = "sn"
    case sachsenAnhalt = "st"
    case schleswigHolstein = "sh"
    case thüringen = "th"
    
    var id: String {
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
            return .init(id: self.id, name: "None Selected", info: "No Residence State selected")
            
        case .bayern:
            return .init(id: self.id, name: "Bayern", info: "Der Freistaat ist mit 70.550 km² das größte Bundesland")
            
        case .badenWürttemberg:
            return .init(id: self.id, name: "Baden-Württemberg", info: "Das Ländle, 35.751 km² groß")
            
        case .berlin:
            return .init(id: self.id, name: "Berlin", info: "Die Hauptstadt der Bundesrepublik Deutschland")
            
        case .brandenburg:
            return .init(id: self.id, name: "Brandenburg", info: "Reich an Naturparks, Wäldern, Seen und Wassergebieten")
            
        case .bremen:
            return .init(id: self.id, name: "Bremen", info: "Zwei-Städte-Staat an der Weser")
            
        case .hamburg:
            return .init(id: self.id, name: "Hamburg", info: "Stadtstaat und zweitgrößte Stadt Deutschlands")
            
        case .hessen:
            return .init(id: self.id, name: "Hessen", info: "Eine der am dichtesten besiedelten Regionen Deutschlands")
            
        case .mecklenburgVorpommern:
            return .init(id: self.id, name: "Mecklenburg-Vorpommern", info: "Wasserreiches Land an der Ostsee mit ca. 2000 km Küstenlinie")
            
        case .niedersachsen:
            return .init(id: self.id, name: "Niedersachsen", info: "Das flächenmäßig zweitgrößte Bundesland")
            
        case .nordrheinWestfalen:
            return .init(id: self.id, name: "Nordrhein-Westfalen", info: "Mit 17,9 Mio. das bevölkerungsreichste Bundesland")
            
        case .rheinlandPfalz:
            return .init(id: self.id, name: "Rheinland-Pfalz", info: "Ein junges Land auf historischem Boden")
            
        case .saarland:
            return .init(id: self.id, name: "Saarland", info: "Das kleinste Flächenland Deutschlands")
            
        case .sachsen:
            return .init(id: self.id, name: "Sachsen", info: "Freistaat Sachsen")
            
        case .sachsenAnhalt:
            return .init(id: self.id, name: "Sachsen-Anhalt", info: "Bundesland mit der höchsten Dichte an UNESCO-Weltkulturerben in Deutschland")
            
        case .schleswigHolstein:
            return .init(id: self.id, name: "Schleswig-Holstein", info: "Das Land zwischen der Nord- und Ostsee")
            
        case .thüringen:
            return .init(id: self.id, name: "Thüringen", info: "Freistaat Thüringen")
            
        }
    }
}

extension StateModel {
    var federalState: FederalState {
        return FederalState(rawValue: self.id) ?? .noneSelected
    }
}

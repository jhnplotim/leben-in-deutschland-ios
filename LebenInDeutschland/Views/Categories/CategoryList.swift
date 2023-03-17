//
//  CategoryList.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 17.03.23.
//

import SwiftUI

struct CategoryList: View {
    // TODO: Add categories to DataModel
    private let categories = ["Deutschland und die Deutschen",
                "Grundlinien deutscher Geschichte",
                "Verfassung und Grundrechte",
                "Wahlen, Parteien und Interessenverbände",
                "Parlament, Regierung und Streitkräfte",
                "Bundesstaat, Rechtsstaat und Sozialstaat",
                "Deutschland in Europa",
                "Kultur und Wissenschaft",
                "Deutsche Nationalsymbole" ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(categories, id: \.self) { cat in
                    NavigationLink(destination: Text(cat)) {
                        Text(cat)
                    }
                }
            }
            .navigationTitle("Categories")
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
    }
}

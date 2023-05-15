//
//  CategoryList.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 17.03.23.
//

import SwiftUI

struct CategoryList: View {
    // ViewModel
    @StateObject
    var viewModel: CategoryListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.categories) { cat in
                    NavigationLink(destination: CategoryDetail(viewModel: .init(category: cat))) {
                        Text(cat.name)
                    }
                }
            }
            .navigationTitle("Categories")
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList(viewModel: .init())
    }
}

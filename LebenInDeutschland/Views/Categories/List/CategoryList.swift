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
    
    // Added to make this View more testable in the preview
    var getDetailVMFactory: (CategoryModel) -> CategoryDetailViewModel = { cat in
        // swiftlint:disable force_unwrapping
        DIResolver.shared.resolve(CategoryDetailViewModel.self, argument: cat)!
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.categories) { cat in
                    NavigationLink(destination: CategoryDetail(viewModel: getDetailVMFactory(cat))) {
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
        CategoryList(viewModel: .init(CategoryServiceImpl())) { cat in
            // TODO: Build CategoryDetailViewModel with test dependencies
            CategoryDetailViewModel(category: cat, QuestionServiceImpl())
        }
    }
}

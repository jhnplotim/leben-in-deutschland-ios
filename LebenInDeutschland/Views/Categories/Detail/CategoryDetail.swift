//
//  CategoryDetail.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 15.05.23.
//

import SwiftUI

struct CategoryDetail: View {
    // ViewModel
    @StateObject
    var viewModel: CategoryDetailViewModel
    
    @State private var assessmentType: AssessmentType?
    
    var body: some View {
        List(viewModel.questions) { qn in
            Text(qn.title).multilineTextAlignment(TextAlignment.leading)
                .onTapGesture {
                    assessmentType = .category(categoryId: viewModel.category.id)
                }
        }
        .navigationTitle(viewModel.category.name)
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(item: $assessmentType) { value in
            AssessmentView(assessmentType: value)
        }
    }
}

struct CategoryDetail_Previews: PreviewProvider {
    static let category = CategoryModel(id: 1, name: "Test Category")
    static var previews: some View {
        CategoryDetail(viewModel: .init(category: category))
    }
}

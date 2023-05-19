//
//  FavoritesView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 19.05.23.
//

import SwiftUI

struct FavoritesView: View {
    
    enum C {
        static let navigationTitle = "Favorites"
    }
    
    @State private var assessmentType: AssessmentType?
    
    @StateObject
    var viewModel: FavoritesViewModel
    
    var assessVMFactory: (AssessmentType) -> AssessmentViewModel = { assType in
        DIResolver.shared.resolve(AssessmentViewModel.self, argument: assType)!
    }
    
    var body: some View {
        NavigationView {
            if viewModel.favorites.isEmpty {
                Text("No favorites at this time!")
            } else {
                List(viewModel.favorites) { qn in
                    Text(qn.title)
                        .multilineTextAlignment(TextAlignment.leading)
                        .font(.caption)
                        .onTapGesture {
                            assessmentType = .favorite
                        }
                }
                .navigationTitle(C.navigationTitle)
                .navigationBarTitleDisplayMode(.automatic)
                .sheet(item: $assessmentType) { value in
                    AssessmentView(viewModel: assessVMFactory(value))
                }
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(viewModel: .init(questionService: QuestionServiceImpl()))
    }
}

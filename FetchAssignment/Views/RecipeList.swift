//
//  RecipeList.swift
//  FetchAssignment
//
//  Created by Guanglei Liu on 1/18/25.
//

import SwiftUI

struct RecipeList: View {

    @State private var viewModel = RecipeListViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.recipes, id: \.self) { recipe in
                RecipeRow(recipe)
            }
            .refreshable {
                try? await viewModel.fetchRecipes()
            }
            .task {
                try? await viewModel.fetchRecipes()
            }
            .navigationTitle("Recipes")
        }
    }
}

#Preview {
    RecipeList()
}

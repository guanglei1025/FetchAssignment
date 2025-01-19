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
            List(viewModel.recipes) { recipe in
                RecipeRow(recipe)
            }
            .navigationTitle("Recipes")
            .refreshable {
                do {
                    try await viewModel.fetchRecipes()
                } catch {
                    print("Please handle error: \(error)")
                }
            }
            .task {
                do {
                    try await viewModel.fetchRecipes()
                } catch {
                    print("Please handle error: \(error)")
                }
            }
        }
    }
}

#Preview {
    RecipeList()
}

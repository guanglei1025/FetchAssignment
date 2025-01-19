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
            bodyContent
            .navigationTitle("Recipes")
            .refreshable {
                do {
                    try await viewModel.getRecipes()
                } catch {
                    print("Please handle error: \(error)")
                }
            }
            .task {
                do {
                    try await viewModel.getRecipes()
                } catch {
                    print("Please handle error: \(error)")
                }
            }
        }
    }

    private var bodyContent: some View {
        List {
            ForEach(Array(viewModel.groupedRecipes.keys), id: \.self) { section in
                Section(header: Text(section)) {
                    ForEach(viewModel.groupedRecipes[section] ?? []) { recipe in
                        RecipeRow(recipe)
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeList()
}

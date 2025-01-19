//
//  RecipeRow.swift
//  FetchAssignment
//
//  Created by Guanglei Liu on 1/18/25.
//

import SwiftUI

struct RecipeRow: View {

    let recipe: Recipe

    init(_ recipe: Recipe) {
        self.recipe = recipe
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe.name)
                .font(.title3)
            Text(recipe.cuisine)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    RecipeRow(Recipe(name: "Name", cuisine: "Cuisine"))
}

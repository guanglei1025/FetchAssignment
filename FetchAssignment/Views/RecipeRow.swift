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
        HStack {
            CachedAsyncImage(url: recipe.iconURL!) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                        .cornerRadius(5)
                case .failure:
                    Image(systemName: "slash.circle")
                default:
                    Image(systemName: "book")
                }
            }

            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.title3)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    RecipeRow(Recipe.Mock())
}

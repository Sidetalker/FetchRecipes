//
//  RecipeLoadingView.swift
//  FetchRecipes
//
//  Created by Kevin Sullivan on 1/18/25.
//

import SwiftUI

struct RecipeLoadingView: View {
    let recipes: [Recipe] = {
        var recipes: [Recipe] = []
        for _ in 0..<10 {
            recipes.append(Recipe(
                uuid: UUID().uuidString,
                cuisine: String(repeating: "X", count: 10),
                name: String(repeating: "X", count: 10)))
        }
        return recipes
    }()
    
    var body: some View {
        HStack {
            List(recipes) { recipe in
                RecipeRow(recipe: recipe)
                    .redacted(reason: .placeholder)
            }
        }
        
    }
}

#Preview {
    RecipeLoadingView()
}

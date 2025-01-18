//
//  RecipeListView.swift
//  FetchRecipes
//
//  Created by Kevin Sullivan on 1/18/25.
//

import SwiftUI

struct RecipeListView: View {
    var recipes: [Recipe]
    
    var body: some View {
        List(recipes) { recipe in
            RecipeRow(recipe: recipe)
        }
    }
}

#Preview {
    RecipeListView(recipes: Array(repeating: Recipe.placeholder, count: 10))
}

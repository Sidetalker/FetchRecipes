//
//  RecipeLoadingView.swift
//  FetchRecipes
//
//  Created by Kevin Sullivan on 1/18/25.
//

import SwiftUI

struct RecipeLoadingView: View {
    var body: some View {
        ForEach(1..<10) { _ in
            RecipeRow(recipe: Recipe.placeholder)
        }
        .redacted(reason: .placeholder)
    }
}

#Preview {
    RecipeLoadingView()
}

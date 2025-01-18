//
//  RecipeRow.swift
//  FetchRecipes
//
//  Created by Kevin Sullivan on 1/18/25.
//

import SwiftUI

struct RecipeRow: View {
    private let imageCache = ImageCacheService()
    
    var recipe: Recipe
    
    @State private var smallImage: UIImage?
    @State private var largeImage: UIImage?
    private let placeholderImage: UIImage = #imageLiteral(resourceName: "recipePlaceholder")
    private var recipeImage: UIImage {
        return largeImage ?? smallImage ?? placeholderImage
    }
    
    var body: some View {
        HStack {
            Image(uiImage: recipeImage)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(.rect(cornerRadius: 10))
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(10)
        }
        .task {
            if let smallUrl = recipe.photoUrlSmall {
                smallImage = try? await imageCache?.fetchImage(from: smallUrl)
            }
            if let largeUrl = recipe.photoUrlLarge {
                largeImage = try? await imageCache?.fetchImage(from: largeUrl)
            }
        }
    }
}

#Preview {
    RecipeRow(recipe: Recipe.placeholder)
}

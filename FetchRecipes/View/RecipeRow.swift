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
    
    @Environment(\.openURL) var openURL
    @State private var smallImage: UIImage?
    @State private var largeImage: UIImage?
    private let placeholderImage: UIImage = #imageLiteral(resourceName: "recipePlaceholder")
    private var recipeImage: UIImage {
        return largeImage ?? smallImage ?? placeholderImage
    }
    
    var body: some View {
        DisclosureGroup {
            HStack {
                Spacer()
                if let youtubeUrl = recipe.youtubeUrl {
                    Image(uiImage: #imageLiteral(resourceName: "youtubeLogo"))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 20)
                        .onTapGesture {
                            openURL(youtubeUrl)
                        }
                    Spacer()
                }
                if let recipeUrl = recipe.sourceUrl {
                    Button("View Recipe") {
                        openURL(recipeUrl)
                    }
                    .buttonStyle(.bordered)
                    Spacer()
                }
            }
        } label: {
            HStack {
                Image(uiImage: recipeImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(.rect(cornerRadius: 10))
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text(recipe.cuisine)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(10)
                Spacer()
            }
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

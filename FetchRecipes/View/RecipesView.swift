//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Kevin Sullivan on 1/18/25.
//

import SwiftUI

struct RecipesView: View {
    @State private var searchText = ""
    @State private var viewModel = RecipesViewModel()
    
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return viewModel.recipes
        } else {
            return viewModel.recipes.filter {
                $0.name.contains(searchText) ||
                $0.cuisine.contains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading:
                    RecipeLoadingView()
                case .emptyData:
                    Text("Empty Data")
                case .malformedData:
                    Text("Malformed Data")
                case .networkError:
                    Text("Network Error")
                case .loaded:
                    RecipeListView(recipes: filteredRecipes)
                }
            }
            .navigationTitle("Recipes")
            .searchable(text: $searchText)
            .refreshable {
                await viewModel.fetchRecipes()
            }
            .task {
                await viewModel.fetchRecipes()
            }
        }
    }
}

#Preview {
    RecipesView()
}

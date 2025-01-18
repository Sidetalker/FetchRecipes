//
//  RecipeErrorView.swift
//  FetchRecipes
//
//  Created by Kevin Sullivan on 1/18/25.
//

import SwiftUI

extension RecipeViewState {
    var errorText: String {
        switch self {
        case .emptyData: return "No Recipes Found"
        case .malformedData: return "Malformed Data"
        case .networkError: return "Network Error"
        default: return ""
        }
    }
    
    var errorImage: String {
        switch self {
        case .emptyData: return "xmark.circle"
        case .malformedData: return "exclamationmark.octagon"
        case .networkError: return "bolt.horizontal.circle"
        default: return ""
        }
    }
}

struct RecipeErrorView: View {
    let errorState: RecipeViewState
    var action: (() async -> Void)? = nil
    @State private var isLoading = false
    
    var body: some View {
        ContentUnavailableView {
            Label(errorState.errorText, systemImage: errorState.errorImage)
        } actions: {
            Button("Refresh") {
                isLoading = true
                Task {
                    await action?()
                    isLoading = false
                }
            }.disabled(isLoading)
        }
    }
}

#Preview {
    RecipeErrorView(errorState: .malformedData)
}

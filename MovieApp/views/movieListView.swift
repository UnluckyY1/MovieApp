//
//  movieListView.swift
//  MovieApp
//
//  Created by Yassine Benmassaoud on 20/7/2025.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    private let gridColumns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.yellow)
                } else if let error = viewModel.errorMessage {
                    ErrorView(message: error, onRetry: {
                        Task { await viewModel.loadMovies() }
                    })
                } else {
                    ScrollView {
                        VStack(spacing: 0) {
                            HeaderView()
                                .padding(.bottom, 16)
                            
                            LazyVGrid(columns: gridColumns, spacing: 16) {
                                ForEach(viewModel.movies) { movie in
                                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                                        MoviePosterView(movie: movie)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .task {
                await viewModel.loadMovies()
            }
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("WOOKIE")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.yellow)
            
            Text("MOVIES")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding()
        .background(Color.primaryDark)
    }
}


struct ErrorView: View {
    let message: String
    let onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(.yellow)
            
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            Button("Retry", action: onRetry)
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background) // Use defined background color
    }
}


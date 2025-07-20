//
//  movieListViewModel.swift
//  MovieApp
//
//  Created by Yassine Benmassaoud on 20/7/2025.
//

import SwiftUI
import Combine

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let movieService: MovieServiceProtocol
    
    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
    }
    
    func loadMovies() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            movies = try await movieService.fetchMovies()
        } catch {
            handleError(error)
        }
    }
    
    private func handleError(_ error: Error) {
        switch error {
        case NetworkError.invalidURL:
            errorMessage = "Invalid endpoint URL"
        case NetworkError.decodingError:
            errorMessage = "Failed to parse response"
        case NetworkError.serverError(let code):
            errorMessage = "Server error (\(code))"
        default:
            errorMessage = error.localizedDescription
        }
    }
}

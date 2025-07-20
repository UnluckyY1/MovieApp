//
//  movieService.swift
//  MovieApp
//
//  Created by Yassine Benmassaoud on 20/7/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(statusCode: Int)
}

protocol MovieServiceProtocol {
    func fetchMovies() async throws -> [Movie]
}

class MovieService: MovieServiceProtocol {
    private let baseURL = "https://wookie.codesubmit.io/movies"
    private let token = "Wookie2019"
    
    func fetchMovies() async throws -> [Movie] {
        guard let url = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(MoviesResponse.self, from: data)
            return response.movies
        } catch {
            throw NetworkError.decodingError
        }
    }
}

struct MoviesResponse: Decodable {
    let movies: [Movie]
}

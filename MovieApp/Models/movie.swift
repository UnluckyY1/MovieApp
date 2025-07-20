//
//  movie.swift
//  MovieApp
//
//  Created by Yassine Benmassaoud on 20/7/2025.
//

import Foundation

struct Movie: Identifiable, Decodable {
    let id: String
    let title: String
    let backdrop: URL?
    let cast: [String]
    let classification: String
    let directors: [String]
    let genres: [String]
    let imdbRating: Double
    let length: String
    let overview: String
    let poster: URL?
    let releasedOn: Date
    let slug: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, backdrop, cast, classification, genres, length, overview, poster, slug
        case imdbRating = "imdb_rating"
        case releasedOn = "released_on"
        case director
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        backdrop = try container.decodeIfPresent(URL.self, forKey: .backdrop)
        cast = try container.decode([String].self, forKey: .cast)
        classification = try container.decode(String.self, forKey: .classification)
        genres = try container.decode([String].self, forKey: .genres)
        imdbRating = try container.decode(Double.self, forKey: .imdbRating)
        length = try container.decode(String.self, forKey: .length)
        overview = try container.decode(String.self, forKey: .overview)
        poster = try container.decodeIfPresent(URL.self, forKey: .poster)
        slug = try container.decode(String.self, forKey: .slug)
        
        if let directorArray = try? container.decode([String].self, forKey: .director) {
            directors = directorArray
        } else {
            let singleDirector = try container.decode(String.self, forKey: .director)
            directors = [singleDirector]
        }
        
        // Date decoding
        let dateString = try container.decode(String.self, forKey: .releasedOn)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        releasedOn = formatter.date(from: dateString) ?? Date()
    }
    
    var year: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: releasedOn)
    }
    
    var directorText: String {
        directors.joined(separator: ", ")
    }
    
    var castText: String {
        cast.joined(separator: ", ")
    }
    
    var genresText: String {
        genres.joined(separator: " • ")
    }
}



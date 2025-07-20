//
//  MovieMock.swift
//  MovieApp
//
//  Created by Yassine Benmassaoud on 20/7/2025.
//

import Foundation

extension Movie {
    init(
        id: String,
        title: String,
        backdrop: URL?,
        cast: [String],
        classification: String,
        directors: [String],
        genres: [String],
        imdbRating: Double,
        length: String,
        overview: String,
        poster: URL?,
        releasedOn: Date,
        slug: String
    ) {
        self.id = id
        self.title = title
        self.backdrop = backdrop
        self.cast = cast
        self.classification = classification
        self.directors = directors
        self.genres = genres
        self.imdbRating = imdbRating
        self.length = length
        self.overview = overview
        self.poster = poster
        self.releasedOn = releasedOn
        self.slug = slug
    }
    
    static let mock = Movie(
        id: "tt1234567",
        title: "The Great Adventure",
        backdrop: URL(string: "https://image.tmdb.org/t/p/original/backdrop.jpg"),
        cast: ["John Jacob", "Hans Meir", "Mohammad Ali"],
        classification: "PG-13",
        directors: ["Christopher Nolan"],
        genres: ["Action", "Adventure", "Sci-Fi"],
        imdbRating: 8.5,
        length: "2h 28m",
        overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque porttitor elit velit, ac aliquam urna venenatis vel. Proesent bibendum, odio eu auctor pellentesque, augue lectus consectetur augue, ut rutrum tortor eros eu orci. Duis ut feugiat arcu. Nullam et sapien erat. Vestibulum rhoncus, enim.",
        poster: URL(string: "https://image.tmdb.org/t/p/original/poster.jpg"),
        releasedOn: Date(),
        slug: "the-great-adventure"
    )
}

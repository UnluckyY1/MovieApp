//
//  movieDetailView.swift
//  MovieApp
//
//  Created by Yassine Benmassaoud on 20/7/2025.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                backdropSection
                    .frame(height: 250)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 20) {
                    posterAndMetadataSection
                        .padding(.top, -130) 
                    
                    descriptionSection
                    genresSection
                }
                .padding(24)
                .background(Color.background)
                .offset(y: -90)
               
            }
        }
        .background(Color.background)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Subviews
    
    private var backdropSection: some View {
        ZStack(alignment: .top) {
            AsyncImage(url: movie.backdrop) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                    
                default:
                    Color.primaryDark
                        .frame(height: 250)
                        .overlay(
                            Image(systemName: "film.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .foregroundColor(.white.opacity(0.3))
                        )
                }
            }
            
            
        }
    }
    
    private var posterAndMetadataSection: some View {
        HStack(alignment: .top, spacing: 16) {
            MoviePosterView(movie: movie, showRatingBadge: false)
                .frame(width: 120, height: 180)
                .cornerRadius(8)
                .shadow(radius: 4)
            
            VStack(alignment: .leading) {
                HStack(alignment: .bottom,spacing: 4) {     Text(movie.title)
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
                    Text(String(format: "%.1f", movie.imdbRating))
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.black)
                        .padding(6)
                        .background(Color.yellow)
                        .clipShape(Circle())
                        .offset(x: 8, y: -8)
                }
                    Spacer()
                
                HStack(spacing: 4) {
                    ForEach(0..<5, id: \.self) { index in
                        Image(systemName: index < Int(round(movie.imdbRating / 10 * 5)) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                    }
                }
            }
            .frame( height: 150)
           
            
           
        }
        
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 12) {
                // Year | Length | Director
                Text("\(movie.year) | \(movie.length) | \(movie.directorText)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()
                    .background(Color.gray.opacity(0.3))
                
                // Cast
                VStack(alignment: .leading, spacing: 4) {
                    Text("Cast")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(movie.castText)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            
            Divider()
                .background(Color.gray.opacity(0.3))
            
            Text("Description")
                .font(.headline)
                .foregroundColor(.white)
            
            Text(movie.overview)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
                .lineSpacing(6)
            
            Divider()
                .background(Color.gray.opacity(0.3))
        }
    }
    
    private var genresSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Genres")
                .font(.headline)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(movie.genres, id: \.self) { genre in
                        Text(genre)
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.yellow.opacity(0.2))
                            .foregroundColor(.yellow)
                            .cornerRadius(12)
                    }
                }
            }
        }
    }
}


struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movie: Movie.mock)
                .preferredColorScheme(.dark)
        }
    }
}

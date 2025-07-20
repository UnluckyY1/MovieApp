//
//  MoviePosterView.swift
//  MovieApp
//
//  Created by Yassine Benmassaoud on 20/7/2025.
//

import SwiftUI

struct MoviePosterView: View {
    let movie: Movie
    var showRatingBadge: Bool = true
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: movie.poster) { phase in
                Group {
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    case .failure:
                        Image(systemName: "film.fill")
                            .resizable()
                            .scaledToFit()
                            .padding(20)
                            .foregroundColor(.white.opacity(0.3))
                        
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.primaryDark.opacity(0.7))
                .cornerRadius(8)
                .clipped()
            }
            
            if showRatingBadge {
                Text(String(format: "%.1f", movie.imdbRating))
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.black)
                    .padding(6)
                    .background(Color.yellow)
                    .clipShape(Circle())
                    .offset(x: 8, y: -8)
            }
        }
        .padding(showRatingBadge ? 4 : 0)
    }
}

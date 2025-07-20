//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Yassine Benmassaoud on 20/7/2025.
//

import SwiftUI

@main
struct MovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListView().preferredColorScheme(.dark)
        }
    }
}

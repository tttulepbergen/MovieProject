//
//  MovieProjectApp.swift
//  MovieProject
//
//  Created by Тулепберген Анель  on 09.05.2025.
//

import SwiftUI

struct MovieApp: View {
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            NavigationView {
                SearchView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            
            NavigationView {
                FavoriteView()
            }
            .tabItem {
                Image(systemName: "heart")
                Text("Favorites")
            }
        }
        .accentColor(.blue)
        .environmentObject(favoritesViewModel)
    }
}

//
//  UserDefaultManager.swift
//  MovieProject
//
//  Created by Тулепберген Анель  on 08.05.2025.
//

import Foundation

struct UserDefaultsManager {
    static let key = "FavoriteMovies"

    static func loadFavorites() -> [Title] {
        if let data = UserDefaults.standard.data(forKey: key) {
            return (try? JSONDecoder().decode([Title].self, from: data)) ?? []
        }
        return []
    }

    static func saveFavorites(_ movies: [Title]) {
        if let encoded = try? JSONEncoder().encode(movies) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}

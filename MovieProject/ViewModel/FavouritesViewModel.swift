import Foundation
import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favoriteMovies: [Title] = []

    init() {
        loadFavorites()
    }

    func loadFavorites() {
        favoriteMovies = UserDefaultsManager.loadFavorites()
    }

    func addFavorite(_ movie: Title) {
        if !favoriteMovies.contains(movie) {
            favoriteMovies.append(movie)
            saveFavorites()
        }
    }

    func removeFavorite(_ movie: Title) {
        favoriteMovies.removeAll { $0.id == movie.id }
        saveFavorites()
    }

    func saveFavorites() {
        UserDefaultsManager.saveFavorites(favoriteMovies)
    }

    func clearAllFavorites() {
        favoriteMovies.removeAll()
        saveFavorites()
    }

    func isFavorite(_ movie: Title) -> Bool {
        favoriteMovies.contains(movie)
    }
}

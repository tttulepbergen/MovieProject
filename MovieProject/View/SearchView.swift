import SwiftUI
import Kingfisher

struct SearchView: View {
    @State private var searchText = ""
    @State private var movies: [Title] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            // Новый дизайн поисковой строки как на изображении
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 12)
                
                TextField("Search", text: $searchText, onCommit: {
                    searchMovies(query: searchText)
                })
                .foregroundColor(.black)
                .padding(.vertical, 10)
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 12)
                    }
                }
            }
            .background(Color(.systemGray5))
            .cornerRadius(10)
            .padding([.horizontal, .top])
            
            // Остальная часть остается без изменений
            if isLoading {
                ProgressView("Searching...")
                    .foregroundColor(.gray)
                    .padding()
            } else if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else if movies.isEmpty && !searchText.isEmpty {
                VStack {
                    Text("No search results")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("Your search results will be displayed here.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
            } else {
                List(movies, id: \.id) { movie in
                    NavigationLink(destination: MovieDetailsView(movie: movie)) {
                        MovieRow(movie: movie)
                            .foregroundColor(.white)
                    }
                    .listRowBackground(Color(red: 37/255, green: 10/255, blue: 2/255))
                }
                .listStyle(PlainListStyle())
            }

            Spacer()
        }
        .navigationTitle("Search")
        .foregroundColor(.white)
        .background(Color(red: 37/255, green: 10/255, blue: 2/255).edgesIgnoringSafeArea(.all))
    }

    private func searchMovies(query: String) {
        guard !query.isEmpty else { return }
        isLoading = true
        errorMessage = nil

        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let movies):
                    self.movies = movies
                case .failure(let error):
                    self.errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
                    self.movies = []
                }
            }
        }
    }
}

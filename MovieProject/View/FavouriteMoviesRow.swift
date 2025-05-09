import SwiftUI

struct FavouriteMoviesRow: View {
    var movie: Title
    
    var body: some View {
        NavigationLink(destination: MovieDetailsView(movie: movie)) {
            HStack {
                // Исправление: AsyncImage с дополнительными параметрами
                AsyncImage(url: URL(string: movie.posterUrl)) { phase in
                    switch phase {
                    case .empty:
                        Color.gray
                            .frame(width: 60, height: 90)
                            .cornerRadius(8)
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 90)
                            .cornerRadius(8)
                            .clipped()
                    case .failure:
                        Color.red
                            .frame(width: 60, height: 90)
                            .cornerRadius(8)
                    @unknown default:
                        Color.gray
                            .frame(width: 60, height: 90)
                            .cornerRadius(8)
                    }
                }
                
                // Текстовое описание фильма
                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.title)
                        .foregroundColor(.white)
                        .font(.headline)
                        .lineLimit(2)
                }
                .padding(.leading, 8)
                
                Spacer()
            }
            .padding(.vertical, 8)
            .background(Color.black.opacity(0.7)) // Фон с прозрачностью
            .cornerRadius(10)
        }
    }
}

import SwiftUI
import Kingfisher

struct MovieRow: View {
    let movie: Title

    var body: some View {
        HStack {
            KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")"))
                .placeholder { Image(systemName: "photo.artframe") }
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 150)  // Увеличиваем размер изображения
                .clipped()

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.original_title ?? movie.original_name ?? "Unknown Title")
                    .font(.title2)  // Увеличиваем размер шрифта для названия
                    .fontWeight(.bold)  // Устанавливаем жирное начертание

                HStack(spacing: 8) {  // Увеличиваем пространство между звездой и цифрами
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 18))  // Увеличиваем размер звезды

                    Text(String(format: "%.1f", movie.vote_average))
                        .foregroundColor(.white)
                        .font(.title3)  // Увеличиваем размер шрифта для цифры
                        .fontWeight(.medium)  // Устанавливаем жирное начертание
                }
            }
            Spacer()
        }
        .padding(.vertical, 6)  // Увеличиваем вертикальные отступы
    }
}

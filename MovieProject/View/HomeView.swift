import SwiftUI
import Kingfisher
import WebKit

struct HomeView: View {
    @State private var trendingMovies: [Title] = []
    @State private var selectedMovie: Title?
    
    // State for showing the user sign-up form
    @State private var isUserFormPresented = false
    
    // User details
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor.systemGray5
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.darkGray
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        UINavigationBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Home")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Button(action: {
                        isUserFormPresented.toggle()
                    }) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50) // Увеличиваем размер области
                            .contentShape(Rectangle()) // Делаем всю область кликабельной
                    }
                    .padding(.trailing)
                }
                .padding([.top, .leading, .trailing]) // Уменьшаем верхний отступ
                .padding(.top, -50) // Небольшой отступ, если нужно
                
                
                Image("HomePagePicture")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height / 4)
                    .clipped()
                    .cornerRadius(10)
                    .padding([.leading, .trailing])
                
                Text("Trending Movies")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .top])
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(trendingMovies, id: \.id) { movie in
                            NavigationLink(destination: MovieDetailsView(movie: movie)) {
                                MovieRow(movie: movie)
                                    .padding(.bottom, 10)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.leading)
                }
                
                Spacer()
            }
            .background(Color(red: 37/255, green: 10/255, blue: 2/255).edgesIgnoringSafeArea(.all))
            .onAppear(perform: fetchTrendingMovies)
            .sheet(isPresented: $isUserFormPresented) {
                // Present the user form
                UserFormView(userName: $userName, userEmail: $userEmail)
            }
        }
    }
    
    private func fetchTrendingMovies() {
        APICaller.shared.getTrendingMovies { result in
            switch result {
            case .success(let titles):
                trendingMovies = titles
            case .failure(let error):
                print("Error loading movies: \(error.localizedDescription)")
            }
        }
    }
    
 

}

struct UserFormView: View {
    @Binding var userName: String
    @Binding var userEmail: String
    
    // Определяем наши цвета
    let burgundyColor = Color(red: 37/255, green: 10/255, blue: 2/255)
    let whiteColor = Color.white
    
    var body: some View {
        NavigationView {
            ZStack {
                // Бордовый фон на весь экран
                burgundyColor
                    .edgesIgnoringSafeArea(.all)
                
                Form {
                                Section(header: Text("User Information")
                                    .foregroundColor(whiteColor)
                                    .font(.system(size: 24, weight: .semibold))) {

                                    CustomTextField(placeholder: "Name", text: $userName)
                                    CustomTextField(placeholder: "Email", text: $userEmail)
                                        .keyboardType(.emailAddress)
                                }                    .listRowBackground(burgundyColor)
                    
                    Section {
                        Button(action: {
                            print("User Name: \(userName), Email: \(userEmail)")
                        }) {
                            Text("Sign Up/Sign In")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(whiteColor)
                                .cornerRadius(10)
                        }
                    }
                    .listRowBackground(burgundyColor)
                }
                .background(burgundyColor) // Бордовый фон для формы
                .scrollContentBackground(.hidden) // Скрываем стандартный фон
                .colorScheme(.dark) // Темная тема
            }
        }
    }
}

// Кастомное текстовое поле с белой обводкой
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    let burgundyColor = Color(red: 37/255, green: 10/255, blue: 2/255)
    let whiteColor = Color.white
    
    var body: some View {
        TextField(placeholder, text: $text)
            .foregroundColor(whiteColor) // Белый текст
            .padding()
            .background(burgundyColor) // Бордовый фон поля
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(whiteColor, lineWidth: 1) // Белая обводка
            )
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .listRowSeparator(.hidden)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


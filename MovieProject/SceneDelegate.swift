//
//  SceneDelegate.swift
//  MovieProject
//
//  Created by Тулепберген Анель  on 09.05.2025.
//



import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // Создаем экземпляр модели
        let favoritesVM = FavoritesViewModel()
        
        // Создаем главное представление
        let contentView = MovieApp()
            .environmentObject(favoritesVM) // Передаем модель
        
        window?.rootViewController = UIHostingController(rootView: contentView)
        window?.makeKeyAndVisible()
        
        // Устанавливаем цвет фона окна
        window?.backgroundColor = UIColor(red: 128/255, green: 0/255, blue: 0/255, alpha: 1)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // This method can be used to release resources as needed
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // This method is called when the scene becomes active
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // This method is called when the scene will resign active
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions to the background
    }
}

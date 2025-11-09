//
//  FoodBrosApp.swift
//  FoodBros
//
//  Created by Rifluxyss on 11/09/25.
//

import SwiftUI

@main
struct FoodBrosApp: App {
    
    init() {
        setupNavigationAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    RootViewScreen()
                }
            }
        }
    }
    
    func setupNavigationAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "Primary") ?? .systemRed]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "Primary") ?? .systemRed]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}

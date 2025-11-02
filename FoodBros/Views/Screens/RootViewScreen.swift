//
//  RootViewScreen.swift
//  FoodBros
//
//  Created by Muthu on 02/11/25.
//

import SwiftUI

struct RootViewScreen: View {
    @State private var isDataLoaded = false
    @State private var notificationObserver: NSObjectProtocol?
    
    var body: some View {
        ZStack {
            if isDataLoaded {
                WelcomeScreen()
            } else {
                SplashScreen()
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isDataLoaded)
        .onAppear {
            addNotificationObserver()
        }
        .onDisappear {
            removeNotificationObserver()
        }
    }
}

extension RootViewScreen {
    func addNotificationObserver() {
        notificationObserver = NotificationCenter.default.addObserver(
            forName: NotificationIdentifiers.hideSplashScreen,
            object: nil,
            queue: .main
        ) { _ in
            isDataLoaded = true
        }
    }
    
    func removeNotificationObserver() {
        if let observer = notificationObserver {
            NotificationCenter.default.removeObserver(observer)
            notificationObserver = nil
        }
    }
}

#Preview {
    RootViewScreen()
}

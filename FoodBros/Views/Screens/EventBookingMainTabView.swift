//
//  EventBookingMainTabView.swift
//  FoodBros
//
//  Created by Rifluxyss on 30/09/25.
//

import SwiftUI

struct EventBookingMainTabView: View {
    var body: some View {
        TabView {
            EventBookingHomeScreen()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    EventBookingMainTabView()
}

//
//  EventBookingHomeScreen.swift
//  FoodBros
//
//  Created by Muthu on 08/11/25.
//

import SwiftUI

struct EventBookingHomeScreen: View {
    @State private var selectedEvent: String = "Select Event"
    @State private var isEditing: Bool = false
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    AppBackgrounds.gradientBackground
                        .ignoresSafeArea()
                    
                    VStack(spacing: 24) {
                        eventButton
                        
                        Spacer()
                    }
                    .padding()
                }
                .sheet(isPresented: $isEditing) {
                    EventChoiceScreen()
                }
                .navigationTitle("My Events")
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}

extension EventBookingHomeScreen {
    private var eventButton: some View {
        Button(action: {
            isEditing = true
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Your Event")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                    Text(selectedEvent)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                Spacer()
                Image(systemName: "pencil")
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.white.opacity(0.2))
                    .clipShape(Circle())
            }
            .padding()
            .background(
                LinearGradient(
                    colors: [Color.red.opacity(0.9), Color.red],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    EventBookingHomeScreen()
}

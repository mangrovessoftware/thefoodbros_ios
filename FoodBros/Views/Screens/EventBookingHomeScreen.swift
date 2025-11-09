//
//  EventBookingHomeScreen.swift
//  FoodBros
//
//  Created by Muthu on 08/11/25.
//

import SwiftUI

struct EventBookingHomeScreen: View {
    @State private var selectedEvent: EventCategory?
    @State private var promos: [Promo] = []
    
    @State private var isEditing: Bool = false
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            AppBackgrounds.gradientBackground
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                eventButton
                
                promoBanner
                
                Spacer()
            }
            .padding()
            
            if isLoading {
                LoadingIndicator()
            }
        }
        .onAppear {
            isEditing = selectedEvent == nil
            getPromos()
        }
        
        .sheet(isPresented: $isEditing) {
            EventChoiceScreen(selectedEvent: $selectedEvent, isEditing: $isEditing)
        }
    }
    
    private func getPromos() {
        isLoading = true
        
        EventBookingPresenter().getPromos { promos in
            self.promos = promos
            isLoading = false
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
                    Text(selectedEvent?.name ?? "Select your event")
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
    
    private var promoBanner: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(promos) { banner in
                    if let promoImage = banner.imageName {
                        Image(promoImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 180)
                            .clipped()
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    EventBookingHomeScreen()
}

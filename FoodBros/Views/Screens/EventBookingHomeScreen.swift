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
    
    @State private var currentPage: Int = 0
    @State private var autoScrollTimer: Timer?

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
        .onDisappear {
            stopAutoScroll()
        }
        .sheet(isPresented: $isEditing) {
            EventChoiceScreen(selectedEvent: $selectedEvent, isEditing: $isEditing)
        }
    }
    
    private func getPromos() {
        isLoading = true
        
        EventBookingPresenter().getPromos { promos in
            DispatchQueue.main.async {
                self.promos = promos
                self.currentPage = 0
                self.restartAutoScrollIfNeeded()
                self.isLoading = false
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
        GeometryReader { proxy in
            let horizontalPadding: CGFloat = 16
            let cardWidth = proxy.size.width - (horizontalPadding * 2)
            let cardHeight: CGFloat = 180
            
            TabView(selection: $currentPage) {
                ForEach(promos.indices, id: \.self) { index in
                    Group {
                        if let promoImage = promos[index].imageName {
                            Image(promoImage)
                                .resizable()
                                .scaledToFill()
                        }
                    }
                    .frame(width: cardWidth, height: cardHeight)
                    .clipped()
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .padding(.horizontal, horizontalPadding)
                    .tag(index)
                }
            }
            .frame(height: cardHeight)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .animation(.easeInOut(duration: 0.35), value: currentPage)
            .onAppear {
                restartAutoScrollIfNeeded()
            }
            .onChange(of: promos) { _ in
                if currentPage >= promos.count {
                    currentPage = max(0, promos.count - 1)
                }
                restartAutoScrollIfNeeded()
            }
            .onDisappear {
                stopAutoScroll()
            }
        }
        .frame(height: 180)
    }
    
    private func restartAutoScrollIfNeeded() {
        stopAutoScroll()
        guard promos.count > 1 else { return }
        startAutoScroll()
    }
    
    private func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            guard !promos.isEmpty else { return }
            let next = (currentPage + 1) % promos.count
            withAnimation(.easeInOut(duration: 0.35)) {
                currentPage = next
            }
        }
        RunLoop.main.add(autoScrollTimer!, forMode: .common)
    }
    
    private func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
}

#Preview {
    EventBookingHomeScreen()
}

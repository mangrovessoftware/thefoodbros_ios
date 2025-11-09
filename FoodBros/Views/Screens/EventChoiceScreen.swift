//
//  EventChoiceScreen.swift
//  FoodBros
//
//  Created by Muthu on 02/11/25.
//

import SwiftUI

struct EventChoiceScreen: View {
    
    @State var eventCategories: [EventCategory] = []
    @Binding var selectedEvent: EventCategory?
    
    @Binding var isEditing: Bool
    @State private var isLoading: Bool = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        ZStack {
            AppBackgrounds.gradientBackground
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                titleSection
                eventGridSection
                
                AppButtons.primary(
                    type: .saveEvent,
                    disabled: selectedEvent == nil
                ) {
                    isEditing = false
                }
            }
            .padding(.top, 50)
            
            if isLoading {
                LoadingIndicator()
            }
        }
        .onAppear {
            getEventCategories()
        }
    }
    
    private func getEventCategories() {
        isLoading = true
        EventBookingPresenter().getEventCategories { eventCategories in
            DispatchQueue.main.async {
                self.eventCategories = eventCategories
                self.isLoading = false
            }
        }
    }
}

extension EventChoiceScreen {
    
    var titleSection: some View {
        Text("Choose Your Event")
            .font(.title.bold())
            .foregroundColor(Color(.primary))
    }
    
    var eventGridSection: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(eventCategories) { event in
                    Button {
                        withAnimation(.spring()) {
                            selectedEvent = selectedEvent?.id == event.id ? nil : event
                        }
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: event.iconName)
                                .font(.system(size: 35))
                            Text(event.name)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(selectedEvent?.id == event.id ? Color(.primary) : .clear, lineWidth: 2)
                        )
                        .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
        }
    }
}


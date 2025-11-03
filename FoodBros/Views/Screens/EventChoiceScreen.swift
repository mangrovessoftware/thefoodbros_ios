//
//  EventChoiceScreen.swift
//  FoodBros
//
//  Created by Muthu on 02/11/25.
//

import SwiftUI

struct EventChoiceScreen: View {
    
    @State private var selectedEvent: EventCategory? = nil
    @State private var toShowEventBookingMainTabView: Bool = false
    
    let eventCategories: [EventCategory] = [
        EventCategory(name: "Wedding", iconName: "heart.fill"),
        EventCategory(name: "Birthday", iconName: "gift.fill"),
        EventCategory(name: "Corporate Event", iconName: "briefcase.fill"),
        EventCategory(name: "Baby Shower", iconName: "stork.fill"),
        EventCategory(name: "Engagement", iconName: "diamond.fill"),
        EventCategory(name: "Anniversary", iconName: "sparkles"),
        EventCategory(name: "Festival", iconName: "sun.max.fill"),
        EventCategory(name: "Private Party", iconName: "music.note.list")
    ]
    
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
                
                AppButtons.primary(type: .continueAction) {
                    guard let selectedEvent else { return }
                    toShowEventBookingMainTabView = true
                }
            }
            .padding(.top, 50)
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
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(eventCategories) { event in
                    Button {
                        withAnimation(.spring()) {
                            
                            if selectedEvent?.id == event.id {
                                selectedEvent = nil
                            } else {
                                selectedEvent = event
                            }
                            
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
            .padding(.top)
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    EventChoiceScreen()
}


#Preview {
    EventChoiceScreen()
}

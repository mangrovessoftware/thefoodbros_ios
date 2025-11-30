//
//  EventChoiceScreen.swift
//  FoodBros
//
//  Created by Muthu on 02/11/25.
//

import SwiftUI

struct EventChoiceScreen: View {
    
    @ObservedObject var viewModel: EventBookingViewModel
    @Binding var isEditing: Bool
    
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
                    disabled: viewModel.selectedEvent == nil
                ) {
                    isEditing = false
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
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.eventCategories) { event in
                    Button {
                        withAnimation(.spring()) {
                            viewModel.selectedEvent = viewModel.selectedEvent?.id == event.id ? nil : event
                        }
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: event.iconName)
                                .font(.system(size: 35))
                                .foregroundColor(.primary)
                            
                            Text(event.name)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.primary)
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
                                .stroke(viewModel.selectedEvent?.id == event.id ? Color(.systemBlue) : .clear, lineWidth: 2)
                        )
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
        }
    }
}


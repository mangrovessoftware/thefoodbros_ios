//
//  EventBookingViewModel.swift
//  FoodBros
//
//  Created by Muthu on 30/11/25.
//

import Foundation
import SwiftUI

class EventBookingViewModel: ObservableObject {
    @Published var selectedEvent: EventCategory?
    @Published var eventCategories: [EventCategory] = []
    
    @Published var selectedTile: ServiceTile?
    @Published var serviceTiles: [ServiceTile] = []
    
    @Published var promos: [Promo] = []
    
    private let presenter = EventBookingPresenter()
    
    init() {
        loadData()
    }
    
    func loadData() {
        getEventCategories()
        getServiceTiles()
    }
    
    private func getEventCategories() {
        presenter.getEventCategories { categories in
            DispatchQueue.main.async {
                self.eventCategories = categories
            }
        }
    }
    
    private func getServiceTiles() {
        presenter.getServiceTiles { tiles in
            DispatchQueue.main.async {
                self.serviceTiles = tiles
            }
        }
    }
    
    private func getPromos() {
        presenter.getPromos { promos in
            self.promos = promos
        }
    }
}

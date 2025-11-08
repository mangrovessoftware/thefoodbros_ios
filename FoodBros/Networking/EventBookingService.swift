//
//  EventBookingService.swift
//  FoodBros
//
//  Created by Muthu on 08/11/25.
//

import Foundation

struct EventBookingService {
    func getEventCategory(completion: @escaping (_ eventCategories: [EventCategory]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
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
            
            DispatchQueue.main.async {
                completion(eventCategories)
            }
        }
    }
}

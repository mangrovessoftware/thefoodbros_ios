//
//  EventBookingService.swift
//  FoodBros
//
//  Created by Muthu on 08/11/25.
//

import Foundation

struct EventBookingService {
    func getEventCategories(completion: @escaping (_ eventCategories: [EventCategory]) -> Void) {
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
    
    func getServiceTiles(completion: @escaping (_ serviceTiles: [ServiceTile]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let serviceTiles: [ServiceTile] = [
                ServiceTile(tileName: "Service Boys", iconName: "person.3.fill"),
                ServiceTile(tileName: "Catering", iconName: "fork.knife.circle.fill"),
                ServiceTile(tileName: "Camera", iconName: "camera.fill"),
                ServiceTile(tileName: "Decoration", iconName: "theatermasks.fill")
            ]
            
            completion(serviceTiles)
        }
    }
    
    func getPromos(completion: @escaping ([Promo]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            let promos: [Promo] = [
                Promo(title: "Big Sale", subtitle: "Up to 50% off on selected items", imageName: "Banner", linkURL: nil, startDate: nil, endDate: nil),
                Promo(title: "New Event", subtitle: "Join our special launch event", imageName: "Banner", linkURL: nil, startDate: nil, endDate: nil),
                Promo(title: "Limited Offer", subtitle: "Get 1 month free subscription", imageName: "Banner", linkURL: nil, startDate: nil, endDate: nil),
                Promo(title: "Exclusive Deals", subtitle: "Only for premium members", imageName: "Banner", linkURL: nil, startDate: nil, endDate: nil),
                Promo(title: "Holiday Special", subtitle: "Festive discounts up to 70%", imageName: "Banner", linkURL: nil, startDate: nil, endDate: nil)
            ]
            
            DispatchQueue.main.async {
                completion(promos)
            }
        }
    }
}


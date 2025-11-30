//
//  EventBookingPresenter.swift
//  FoodBros
//
//  Created by Muthu on 08/11/25.
//

import Foundation

struct EventBookingPresenter {
    func getEventCategories(completion: @escaping (_ eventCategories: [EventCategory]) -> Void)  {
        EventBookingService().getEventCategories(completion: completion)
    }
    
    func getServiceTiles(completion: @escaping (_ eventCategories: [ServiceTile]) -> Void)  {
        EventBookingService().getServiceTiles(completion: completion)
    }
    
    func getPromos(completion: @escaping (_ promos: [Promo]) -> Void)  {
        EventBookingService().getPromos(completion: completion)
    }
}

//
//  EventBookingPresenter.swift
//  FoodBros
//
//  Created by Muthu on 08/11/25.
//

import Foundation

struct EventBookingPresenter {
    func getEventCategory(completion: @escaping (_ eventCategories: [EventCategory]) -> Void)  {
        EventBookingService().getEventCategory(completion: completion)
    }
}

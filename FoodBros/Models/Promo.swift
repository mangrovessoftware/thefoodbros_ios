//
//  Promo.swift
//  FoodBros
//
//  Created by Muthu on 09/11/25.
//

import Foundation

struct Promo: Identifiable, Equatable {
    let id = UUID()
    let title: String?
    let subtitle: String?
    let imageName: String?
    let linkURL: URL?
    let startDate: Date?
    let endDate: Date?
}

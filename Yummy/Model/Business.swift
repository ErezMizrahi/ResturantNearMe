//
//  Business.swift
//  Yummy
//
//  Created by hackeru on 29/06/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import Foundation
import CoreLocation

struct Root: Codable{
    let businesses: [Business]
}

struct Business: Codable{
    let id: String
    let name: String
    let imageUrl: URL
    let distance: Double
}

struct ResturantsViewModel{
    let name: String
    let imageUrl: URL
    let distance: Double
    let id: String
    
    static var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    
    var formattedDistance: String? {
        return ResturantsViewModel.numberFormatter.string(from: distance as NSNumber)
    }
    
}

extension ResturantsViewModel {
    init(business: Business) {
        self.name = business.name
        self.distance = business.distance / 1699.344
        self.id = business.id
        self.imageUrl = business.imageUrl
    }
}

struct Details: Decodable {
    let price: String
    let phone: String
    let isClosed: Bool
    let rating: Double
    let name: String
    let photos: [URL]
    let coordinates: CLLocationCoordinate2D
}

extension CLLocationCoordinate2D: Decodable {
    
    enum CodingKeys: CodingKey{
        case latitude
        case longitude
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
    
        self.init(latitude: latitude, longitude: longitude)
    }
}


struct DetailsViewModel {
    let name: String
    let price: String
    let isOpen: String
    let phoneNumber: String
    let rating: String
    let imageUrls: [URL]
    let coordinates: CLLocationCoordinate2D
}

extension DetailsViewModel{
    init(details: Details) {
        self.name = details.name
        self.price = details.price
        self.isOpen = details.isClosed ? "Closed" : "Open"
        self.phoneNumber = details.phone
        self.rating = "\(details.rating) / 5.0"
        self.imageUrls = details.photos
        self.coordinates = details.coordinates
    }
}

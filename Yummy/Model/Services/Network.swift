//
//  Network.swift
//  Yummy
//
//  Created by hackeru on 29/06/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import Foundation
import Moya

let apiKey = "VDQIr_azT-3dsWT6dFsp2hvqWgrufegSVlU42gOwfPgUxEN6sbUsy4ga0jhsNbIJ65muHUrSG1GsktS-fBWlPOkIJ0MRBkUm1-9k5z8q5DHV9UfU9sdXnohDR3cXXXYx"

enum NetworkService{
    enum Provider: TargetType{
        case search(lat: Double, long: Double)
        case details(id: String)
        
        
        var baseURL: URL{
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }
        
        var path: String{
            switch self {
            case .search:
                return "/search"
            case let .details(id):
                return "/\(id)"
                
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var task: Task {
            switch self {
            case let .search(lat, lon):
                return .requestParameters(parameters: ["latitude": lat, "longitude": lon, "limit": 10],
                                          encoding: URLEncoding.queryString)
            case .details:
                return .requestPlain
            }
            
        }
        
        var headers: [String : String]? {
            return ["Authorization": "Bearer \(apiKey)"]
        }
        
        
    }
}

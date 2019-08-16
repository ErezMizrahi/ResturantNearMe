//
//  AppManager.swift
//  Yummy
//
//  Created by hackeru on 29/06/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import Foundation
import Moya
class AppManager {
    
    static let appManager = AppManager()
    var locationService: ILocationService
    let service = MoyaProvider<NetworkService.Provider>()
    
    init(_ manager: ILocationService = TrackerModel.shared) {
        self.locationService = manager
    }
    
    typealias getDetailsCallback = (_ details: DetailsViewModel?,_ error: Error?)->Void
    func getDetails(with id: String,_ callback: @escaping getDetailsCallback){
        service.request(.details(id: id)) { (res) in
            switch res {
            case .success(let value):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try decoder.decode(Details.self, from: value.data)
                    let viewModel = DetailsViewModel(details: result)
                    callback(viewModel,nil)
                } catch {
                    print(error)
                }
              
                
                break
            case .failure(let err):
                callback(nil,err)
                break
            }
        }
    }
    
    typealias getLocation = (_ langtitude: Double,_ longtitude: Double)->Void
    func start(_ callback: @escaping getLocation) {
        
        locationService.startLocationService()
        
        locationService.callback = { result in
            
            switch result {
            case .succsess(let location):
                
                callback(location.coordinate.latitude, location.coordinate.longitude)
            case .failure(let err):
                print(err)
            }
            
        }
    }
    
     func stop() {
        locationService.StopLocationService()
    }
    
   
    
    func resturantsListApiResponse(latitude: Double, longtitude: Double, callback: @escaping ([ResturantsViewModel]?, Error?)->Void) {
        self.service.request(.search(lat: latitude, long: longtitude)) { (result) in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do{
                    let result = try decoder.decode(Root.self, from: response.data)
                    let viewModel = result.businesses.compactMap{ResturantsViewModel.init(business: $0)}
                        .sorted{$0.distance < $1.distance}
                    
                    callback(viewModel,nil)
                } catch {
                    callback(nil,error)
                }
            case .failure(let error):
                callback(nil,error)
            }
            
        }
    }
}

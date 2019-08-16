//
//  LocationController.swift
//  Yummy
//
//  Created by hackeru on 29/06/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit


class LocationController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startApp" {
            
            let destVCNavigation = segue.destination as! UINavigationController
            let destVC = destVCNavigation.topViewController as! RestaruntsTableViewController
//            self.delegate = destVC
            destVC.viewModels = sender as? [ResturantsViewModel] ?? []
        }
    }
    
    @IBAction func allowAction(_ sender: UIButton) {
        AppManager.appManager.start{
            (lat, lon) in
          
            AppManager.appManager.resturantsListApiResponse(latitude: lat, longtitude: lon){[weak self] response, err in
                
                guard err == nil else {
                    self?.alertPopUp(with: err!)
                return
                }
                
                self?.performSegue(withIdentifier: "startApp", sender: response)
                
            }
        }
    }
    
    
    
    @IBAction func denyAction(_ sender: UIButton) {
        self.alertPopUp(with: nil)
    }
    
    private func alertPopUp(with err: Error?) {
        let alertController = UIAlertController(title: "Error", message: err?.localizedDescription ?? "Please Allow", preferredStyle: .alert)
        let action = UIAlertAction(title: "Try agine", style: .default, handler: { (_) in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

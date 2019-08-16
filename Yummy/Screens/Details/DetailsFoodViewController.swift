//
//  DetailsFoodViewController.swift
//  Yummy
//
//  Created by hackeru on 29/06/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit
import AlamofireImage
import MapKit
import CoreLocation

class DetailsFoodViewController: UIViewController , IdetailsDelegate{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel: DetailsViewModel? {
        didSet {
            self.updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    private func updateUI() {
        guard let vm = viewModel else { return }
        self.title = vm.name
        priceLabel.text = vm.price
        hoursLabel.text = vm.isOpen
        locationLabel.text = vm.phoneNumber
        ratingLabel.text = vm.rating
        self.collectionView.reloadData()
        self.setupMap(for: vm.coordinates)
    }
    
    @IBAction func habdleControl(_ sender: Any)
    {
        
    }
    
    private func setupMap(for coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        let annotaion = MKPointAnnotation()
        annotaion.coordinate = coordinate
        
        self.mapView.setRegion(region, animated: true)
        self.mapView.addAnnotation(annotaion)
        
    
    }
    
    //delegate method
    func didTapCell(_ viewModel: ResturantsViewModel) {
        print("delegate vm id \(viewModel.id)")
        AppManager.appManager.getDetails(with: viewModel.id) { (details, err) in
            self.viewModel = details
            self.updateUI()
        }
    }

}


extension DetailsFoodViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.imageUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! DetailsCollectionCell
        
        if let url = viewModel?.imageUrls[indexPath.item]  {
            cell.image.af_setImage(withURL: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.item
    }
}

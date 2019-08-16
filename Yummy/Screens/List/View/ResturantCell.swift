//
//  ResturantCell.swift
//  Yummy
//
//  Created by hackeru on 29/06/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit
import AlamofireImage

class ResturantCell: UITableViewCell {

    @IBOutlet weak var markerImageView: UIImageView!
    @IBOutlet weak var resturantImageView: UIImageView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with view: ResturantsViewModel) {
        resturantImageView.af_setImage(withURL: view.imageUrl)
        nameLabel.text = view.name
        distanceLabel.text = view.formattedDistance
        
    }
    
}

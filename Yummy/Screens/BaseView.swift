//
//  BaseView.swift
//  Yummy
//
//  Created by hackeru on 29/06/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

@IBDesignable class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    private func configure() {
        
    }
    
   
}

//
//  ButtonStyling.swift
//  CarBuy
//
//  Created by admin on 4/9/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit

class ButtonStyling: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.7
    }
}



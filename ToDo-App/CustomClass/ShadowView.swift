//
//  ShadowView.swift
//  CarBuy
//
//  Created by admin on 4/9/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit


class ShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addShadow()
    }
    
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}

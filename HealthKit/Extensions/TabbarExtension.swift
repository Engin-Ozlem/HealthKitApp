//
//  TabbarExtension.swift
//  HealthCase
//
//  Created by macbookair on 25.08.2023.
//

import UIKit

class TabbarExtension: UITabBar {

    override func awakeFromNib() {
            super.awakeFromNib()
            
            
            barTintColor = UIColor.darkGray
            
            
            tintColor = UIColor.black
            
           
            layer.borderWidth = 1.0
            layer.borderColor = UIColor.black.cgColor
            
            
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: -2)
            layer.shadowOpacity = 0.5
            layer.shadowRadius = 3.0
        }

}



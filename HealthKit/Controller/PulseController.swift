//
//  PulseController.swift
//  HealthKit
//
//  Created by macbookair on 25.08.2023.
//


import UIKit
import HealthKit




class PulseController: UIViewController {
    
    let healthStore = HKHealthStore()
    
    
    
    

    @IBOutlet weak var viewPulse: UIView!
    @IBOutlet weak var pulseQuantityLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutEdit()
        requestPermission()
        
        
    }
    

    
    func layoutEdit(){
        
        viewPulse.layer.shadowColor = UIColor.black.cgColor
        viewPulse.layer.shadowOffset = CGSize(width: 0, height: 3)
        viewPulse.layer.shadowOpacity = 0.5
        viewPulse.layer.shadowRadius = 4
        viewPulse.layer.cornerRadius = 10
        
    }

}

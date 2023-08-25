//
//  StepController.swift
//  HealthKit
//
//  Created by macbookair on 25.08.2023.
//

import UIKit
import HealthKit

class StepController: UIViewController {
    
    
    
    @IBOutlet weak var viewSteps: UIView!
    let healthStore = HKHealthStore()
    let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)
    
    @IBOutlet weak var Steps: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutEdit()
        requestPermission()

        
    }
    
   
    
    func layoutEdit(){
        
        viewSteps.layer.shadowColor = UIColor.black.cgColor
        viewSteps.layer.shadowOffset = CGSize(width: 0, height: 3)
        viewSteps.layer.shadowOpacity = 0.5
        viewSteps.layer.shadowRadius = 4
        viewSteps.layer.cornerRadius = 10
        
        
        
        
    }
    
}



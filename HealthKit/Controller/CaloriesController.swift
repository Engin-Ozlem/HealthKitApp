//
//  CaloriesController.swift
//  HealthKit
//
//  Created by macbookair on 25.08.2023.
//

import UIKit
import HealthKit

class CaloriesController: UIViewController {
    @IBOutlet weak var viewCalories: UIView!
    
    let healthStore = HKHealthStore()
    let calorieType = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
    
    @IBOutlet weak var calorieLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutEdit()
        requestPermission()
    }
    
    
    
    
    
    func layoutEdit(){
        viewCalories.layer.cornerRadius = 10
        viewCalories.layer.shadowColor = UIColor.black.cgColor
        viewCalories.layer.shadowOffset = CGSize(width: 0, height: 3)
        viewCalories.layer.shadowOpacity = 0.5
        viewCalories.layer.shadowRadius = 4
    }
}


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
    
    func requestPermission() {
        let healthType: Set<HKSampleType> = [calorieType]
        
        healthStore.requestAuthorization(toShare: nil, read: healthType) { success, error in
            if success {
                self.fetchCalorieData()
            } else {
                if let error = error {
                    print("Permission denied: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchCalorieData() {
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.startOfDay(for: now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: calorieType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, samples, error in
            if let error = error {
                print("calorie data could not be retrieved: \(error.localizedDescription)")
                return
            }
            
            if let calorieSamples = samples as? [HKQuantitySample] {
                if let calorieSample = calorieSamples.first {
                    let calorieValue = calorieSample.quantity.doubleValue(for: HKUnit.kilocalorie())
                    DispatchQueue.main.async {
                        
                        self.calorieLabel.text = "\(calorieValue)"
                        let str = CaloriesStr(calories: Int(calorieValue))
                        self.calorieLabel.text = "\(str.calories)"
                    }
                }
            }
        }
        healthStore.execute(query)
    }
    
    func layoutEdit(){
        viewCalories.layer.cornerRadius = 10
        viewCalories.layer.shadowColor = UIColor.black.cgColor
        viewCalories.layer.shadowOffset = CGSize(width: 0, height: 3)
        viewCalories.layer.shadowOpacity = 0.5
        viewCalories.layer.shadowRadius = 4
    }
}


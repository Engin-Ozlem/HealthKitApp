//
//  CaloriesControllerExtension.swift
//  HealthCase
//
//  Created by macbookair on 25.08.2023.
//

import Foundation
import HealthKit

extension CaloriesController {
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
}

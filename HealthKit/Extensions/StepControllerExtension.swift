//
//  StepControllerExtension.swift
//  HealthCase
//
//  Created by macbookair on 25.08.2023.
//

import Foundation
import HealthKit

extension StepController {
    
    func requestPermission() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let healthType : Set<HKSampleType> = [stepType]
        
        healthStore.requestAuthorization(toShare: nil, read: healthType) { success, error in
            if success {
                self.fetchDailyStepCount()
            }else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchDailyStepCount(){
        let calender = Calendar.current
        let now = Date()
        let startDate = calender.startOfDay(for: now)
        let endDate = calender.date(byAdding: .day, value: 1, to: startDate)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: stepCountType!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, samples, error in
            if let error = error {
                print("adım verileri gelmedi \(error.localizedDescription)")
                return
            }
            
            if let stepSamples = samples as? [HKQuantitySample] {
                var totalStepCount = 0
                
                for sample in stepSamples {
                    let stepCount = sample.quantity.doubleValue(for: HKUnit.count())
                    let stepCount2 = Int(stepCount)
                    totalStepCount += stepCount2
                }
                DispatchQueue.main.async {
                    self.Steps.text = "\(totalStepCount)"
                    let str = StepStr(step: Int(totalStepCount))
                    self.Steps.text = "\(str.step)"
                    
                    
                }
            }
        }
        healthStore.execute(query)
    }
    
}

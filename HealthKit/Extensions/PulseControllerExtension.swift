//
//  PulseControllerExtension.swift
//  HealthCase
//
//  Created by macbookair on 25.08.2023.
//

import Foundation
import HealthKit

extension PulseController {
    func requestPermission(){
        let heartType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let healthType : Set<HKSampleType> = [heartType]
        
        healthStore.requestAuthorization(toShare: nil, read: healthType) { success, error in
            if success {
                //permission access
                //self.simulateHeartRate()
                self.fetchDailyData()
                
            }else {
                if let error = error {
                    print("Permission denied : \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    func fetchDailyData(){
       
        let heartType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.startOfDay(for: now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: heartType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, samples, error in
            if let error = error {
                print("heart rate data could not be retrieved : \(error.localizedDescription)")
                return
            }
            
            if let heartSamples = samples as? [HKQuantitySample] {
                for sample in heartSamples {
                    let heartRate = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
                    
                    DispatchQueue.main.async {
                                        let str = PulseStr(pulseQuantity: Int(heartRate))
                                        self.pulseQuantityLbl.text = "\(str.pulseQuantity)"
                                        print("veri geldi \(heartRate)")
                                    }
                    
                }
            }
        }
        healthStore.execute(query)
    
    
    
    }
    
    
}

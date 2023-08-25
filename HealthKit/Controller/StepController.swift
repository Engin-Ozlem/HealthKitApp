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
                    
                }
            }
        }
        healthStore.execute(query)
    }

    
    func layoutEdit(){
        
        viewSteps.layer.shadowColor = UIColor.black.cgColor
        viewSteps.layer.shadowOffset = CGSize(width: 0, height: 3)
        viewSteps.layer.shadowOpacity = 0.5
        viewSteps.layer.shadowRadius = 4
        viewSteps.layer.cornerRadius = 10
        
        
    }
    
}

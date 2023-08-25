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
    var heartQuantity : Int = 0
    
    
    

    @IBOutlet weak var viewPulse: UIView!
    @IBOutlet weak var pulseQuantityLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutEdit()
        //simulateHeartRate()
        requestPermission()
        
        
    }
    

    
    func layoutEdit(){
        
        viewPulse.layer.shadowColor = UIColor.black.cgColor
        viewPulse.layer.shadowOffset = CGSize(width: 0, height: 3)
        viewPulse.layer.shadowOpacity = 0.5
        viewPulse.layer.shadowRadius = 4
        viewPulse.layer.cornerRadius = 10
        
        
    }
    
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

extension PulseController {
    
        /*func generateFakeHeartRateData() -> [Double] {
            var fakeData: [Double] = []
            
            
            for _ in 0..<24 {
                let randomHeartRate = Double.random(in: 60...100)
                fakeData.append(randomHeartRate)
            }
            
            return fakeData
        }

        func simulateHeartRate() {
            let fakeData = generateFakeHeartRateData()
            var currentIndex = 0
            
            let timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
                if currentIndex < fakeData.count {
                    let heartRate = fakeData[currentIndex]
                    DispatchQueue.main.async {
                        self.pulseQuantityLbl.text = "\(heartRate)"
                    }
                    currentIndex += 1
                } else {
                    timer.invalidate()
                }
            }
            timer.fire()
        }*/

       

        
    

}

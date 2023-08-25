//
//  BaseController.swift
//  HealthKit
//
//  Created by macbookair on 25.08.2023.
//

import UIKit

class BaseController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutEdit()
    }
    

    func layoutEdit(){
        continueButton.layer.cornerRadius = 10
        continueButton.layer.shadowColor = UIColor.black.cgColor
        continueButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        continueButton.layer.shadowOpacity = 0.5
        continueButton.layer.shadowRadius = 4
    }

}

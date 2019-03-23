//
//  DetailVC.swift
//  CoreDataTask
//
//  Created by Snehal Garbhe on 3/21/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import Foundation
import UIKit

class DetailVC : BaseVC {
    
   
    @IBOutlet weak var minTempVal: UILabel!
    @IBOutlet weak var maxTempVal: UILabel!
    @IBOutlet weak var humidityVal: UILabel!
    @IBOutlet weak var pressureVal: UILabel!
    
    var cityData: CityData!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail Weather Report"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI(cityData: cityData)

    }
    
    func updateUI(cityData: CityData) {
        
        if let humidity = self.cityData?.humidity {
            humidityVal.text = "\(humidity)"
            
        }
        
        if let pressure = self.cityData?.pressure {
            pressureVal.text = "\(pressure)"
            
        }
        
        if let minTemp = self.cityData?.minTemp {
            minTempVal.text = "\(minTemp)"
        }
        
        if let maxTemp = self.cityData?.maxTemp {
            maxTempVal.text = "\(maxTemp)"
        }
    }
}


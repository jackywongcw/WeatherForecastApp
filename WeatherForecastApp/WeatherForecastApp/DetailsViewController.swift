//
//  DetailsViewController.swift
//  WeatherForecastApp
//
//  Created by Jacky Wong on 22/4/19.
//  Copyright © 2019 Jacky Wong. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    var data: List?
    var dateString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = dateString
        
        windLabel.text = "\(String(describing: data!.wind!.speed!)) meter/sec"
        maxTempLabel.text = "\(String(describing: data!.main!.temp_max!)) K"
        minTempLabel.text = "\(String(describing: data!.main!.temp_min!)) K"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

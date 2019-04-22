//
//  ForecastedResultTableViewCell.swift
//  WeatherForecastApp
//
//  Created by Jacky Wong on 22/4/19.
//  Copyright © 2019 Jacky Wong. All rights reserved.
//

import UIKit

class ForecastedResultTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setForecastedData(_ data: List) {
        let dateInString = Date(timeIntervalSince1970: Double(data.dt!)).toLocalisedTimeString()
        timeLabel.text = dateInString
        statusLabel.text = data.weather!.first?.main?.description
        temperatureLabel.text = "\(String(describing: data.main!.temp!)) K"
    }
    
    func setNoData() {
        
        timeLabel.text = "-"
        statusLabel.text = "-"
        temperatureLabel.text = "-"
    }

}

//
//  HomeViewController.swift
//  WeatherForecastApp
//
//  Created by Jacky Wong on 20/4/19.
//  Copyright © 2019 Jacky Wong. All rights reserved.
//

import UIKit

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
//let numbers = Array(1...100)
//let result = numbers.chunked(into: 5)

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var forcastedTableView: UITableView!
    
    var _currDate = Date()
    var _tempDateString = ""
    
    var dateForDayDict: [String:String] = [:]
    var dataResultForDayDict: [String:[List]] = [:]
    var datesInOrder: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let cityID = "1880252" // Singapore
        
        var request = URLRequest(url: URL(string: "https://api.openweathermap.org/data/2.5/forecast?id=\(cityID)&APPID=\(NameConstant.apiKey)")!)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(Json4Swift_Base.self, from: data!)
                
                if let list = responseModel.list {
                    print("List = ", list)
    
                    // list
                    // for every item in list
                    // check the date
                    var dateIndex = 0
                    for index in 0 ... list.count-1 {
                        if let date = list[index].dt {
                            
                            let dateInString = Date(timeIntervalSince1970: Double(date)).toLocalisedDateString()

                            if self.dataResultForDayDict[dateInString] != nil {
                                var newList = self.dataResultForDayDict[dateInString]!
                                newList.append(list[index])
                                self.dataResultForDayDict.updateValue(newList, forKey: dateInString)
                            }
                            else {
                                self.dataResultForDayDict.updateValue([list[index]], forKey: dateInString)
                            }
                            
                            if index == 0 {
                                self._tempDateString = dateInString
                                self.dateForDayDict.updateValue(dateInString, forKey: "Day\(dateIndex)")
                                dateIndex = dateIndex + 1
                                self.datesInOrder.append(dateInString)
                                continue
                            }
                            
                            if self._tempDateString == dateInString {
                                continue
                            }
                            else {
                                self._tempDateString = dateInString
                                self.dateForDayDict.updateValue(dateInString, forKey: "Day\(dateIndex)")
                                self.datesInOrder.append(dateInString)
                                dateIndex = dateIndex + 1
                            }
                            
                        }
                        
                        // show network error
                    }
                    
                    // for item in list
                    // get list.dt to local time, save to dictionary as day1
                    // if next item .dt is same as previous date (need a key to save the date), continue
                    // if next item is not same as previous date, save to dic
                    
                    // put the date to a dictionary, that key will be use in section header as well
                    DispatchQueue.main.async {
                        self.forcastedTableView.reloadData()
                    }
                }

            } catch {
                print("JSON Serialization error")
                // Show error alert
            }
        }).resume()

    

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dateString = datesInOrder[section]
        
        return dataResultForDayDict[dateString]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ForecastedResultTableViewCell
        
        if datesInOrder.indices.contains(indexPath.section) {
            let dateString = datesInOrder[indexPath.section]
            let datas = dataResultForDayDict[dateString]
            
            cell.setForecastedData(datas![indexPath.row])
            
            return cell
        }
        else {
            cell.setNoData()
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "MoreDetails", sender: datesInOrder[indexPath.section])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // Section
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return datesInOrder.isEmpty ? "nil" : datesInOrder[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataResultForDayDict.isEmpty ? 0 : dataResultForDayDict.count
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "MoreDetails" {
            let vc = segue.destination as! DetailsViewController
            vc.dateString = sender as! String
        }
    }
 

}

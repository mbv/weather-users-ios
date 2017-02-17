//
//  WeatherModel.swift
//  lab2
//
//  Created by Konstantin Terehov on 2/16/17.
//  Copyright © 2017 Konstantin Terehov. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

struct Weather {
    var time : String!
    var temperature : String!
}

class WeatherModel {
    static let sharedInstance : WeatherModel = WeatherModel()
    
    private init() {}
    
    private var weathers : [Weather]? = nil
    
    private var delegate : TableViewAsyncLoadDelegate?
    
    func setDelegate(delegate: TableViewAsyncLoadDelegate) {
        self.delegate = delegate
    }
    
    func getWeathers() -> [Weather] {
        if (weathers == nil) {
            reloadData()
        }
        
        return weathers!
    }

    func reloadData() {
        weathers = [Weather]()
        URLCache.shared.removeAllCachedResponses()
        Alamofire.request("https://api.darksky.net/forecast/7401ca7f2febba29c4182f69694792e8/53.9,27.5667?units=si", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.weathers = [Weather]()
            
                for (_,subJson):(String, JSON) in json["daily"]["data"] {
                    var tmpWeather = Weather()
                    let date = NSDate(timeIntervalSince1970: subJson["time"].double!)
                
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd MMMM yyyy"
                    tmpWeather.time = dateFormatter.string(from: date as Date)
                
                    tmpWeather.temperature = String(subJson["temperatureMin"].double!) + "°C - " + String(subJson["temperatureMax"].double!)+"°C"
                    self.weathers?.append(tmpWeather)
                }
                self.delegate?.updateAfterLoad();
            
            
            case .failure(let error):
                self.delegate?.showAlert(title: "Error", message: "Error getting data. Check your interenet conection")
                print(error)
            }

        }
    }
}

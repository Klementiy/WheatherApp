//
//  detailVC.swift
//  WeatherApp
//
//  Created by user on 25/11/2020.
//

import UIKit
import Alamofire
import SwiftyJSON

class detailVC: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temp_c: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    
    var cityName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentWeather(city: cityName)
    }
    
    func currentWeather(city: String) {
        let url = "https://api.weatherapi.com/v1/current.json?key=67284c3dbd0e4fddb29151120202511&q=\(city)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let name = json["location"]["name"].stringValue
                let temp = json["current"]["temp_c"].doubleValue
                let country = json["location"]["region"].stringValue
                
                self.cityNameLabel.text = name
                self.temp_c.text = String(temp)
                self.countryLabel.text = country

                let weatherURL = URL(string: "http:\(json["current"]["condition"]["icon"].stringValue)")
                if let data = try? Data(contentsOf: weatherURL!) {
                    self.imageWeather.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

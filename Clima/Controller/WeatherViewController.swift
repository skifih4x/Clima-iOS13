//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    var delegate: WeatherManagerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
    }
    
    
    @IBAction func searchPressentButton(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)

        print(searchTextField.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        delegate?.didUpdateWeather(weather: weather)
        print(weather.temperature)
        print(weather.conditionId)
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
}

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

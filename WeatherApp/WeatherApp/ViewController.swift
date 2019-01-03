//
//  ViewController.swift
//  WeatherApp
//
//  Created by Andi Xiong on 2018-12-18.
//  Copyright © 2018 Andi Xiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var sentence: UITextField!
    
    let jsonUrl : String = "https://api.openweathermap.org/data/2.5/weather?id=4699066&APPID=53f3fdfa7dacd867b6b4e36f3266ba8a"
    var temp: Double! = 0
    
    @IBAction func tapped(_ sender: Any) {
        getTemp()
    }
    
    func getTemp() -> Void {
        guard let url : URL = URL(string: self.jsonUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {return}
                guard let main = json["main"] as? [String: Double]  else {return}
                self.temp = main["temp"]
                DispatchQueue.main.async { // Correct
                    self.sentence.text = String(format:"Temperature at Houston: %.2f Celsius.", self.temp - 273.15)
                }
                //print(json)
                print(self.temp)
            } catch let jsonErr {
                print("Json Error: ", jsonErr)
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sentence.text = "Temperature at Houston: ???"
    }

}


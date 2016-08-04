//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ali Mir on 8/3/16.
//  Copyright © 2016 Ali Mir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userCity: UITextField!
    
    @IBOutlet var weatherLabel: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let url = NSURL(string: "http://www.weather-forecast.com/locations/London/forecasts/latest")
        
        if url != nil {
            
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                var urlError = false
                var weather = ""
                
                if error == nil {
                    
                    let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                    
                    let urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray.count > 0 {
                        
                        let weatherArray = urlContentArray[1].componentsSeparatedByString("/<span>")
                        
                        weather = weatherArray[0] as String!
                        
                    } else {
                        urlError = true
                    }
                    
                } else {
                    urlError = true
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    if urlError == true {
                        self.weatherLabel.text = "Error!"
                        
                    } else {
                        self.weatherLabel.text = weather
                        
                        }
                    })
                
             
                
                
            })
            
            task.resume()
            
        } else {
            weatherLabel.text = "Please enter a valid city name!"
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


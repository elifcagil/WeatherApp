//
//  ViewController.swift
//  WeatherApp
//
//  Created by ELİF ÇAĞIL on 17.04.2025.
//

import UIKit
import Alamofire
import Lottie
import CoreLocation

class ViewController: UIViewController {
    var animationView:LottieAnimationView?
    let locationManager = CLLocationManager()
    let apiKey = "<YOUR_API_KEY"
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var temparatureLabel: UILabel!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var uıview: UIView!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var locationButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        applyGradientBackground()

        
        
    }

    
    @IBAction func getWeatherButton(_ sender: UIButton) {
        guard let city = cityTextField.text, !city.isEmpty else {
            showAlert(message: "Please, enter a city")
            return
        }
        fetchWeatherData(for: city)
    }
    
    
    

    func setupUI(){
        searchButton.layer.cornerRadius = 10

        locationButton.layer.cornerRadius = 10
        locationButton.layer.borderColor = UIColor.systemGray.cgColor
        locationButton.layer.borderWidth = 1
        
        cityTextField.layer.cornerRadius = 12
        cityTextField.layer.shadowColor = UIColor.black.cgColor
        cityTextField.layer.shadowOpacity = 0.3
        cityTextField.layer.shadowOffset = CGSize(width: 0, height: 2)
        cityTextField.layer.shadowRadius = 6
        
        loadingIndicator.isHidden = true
        
        uıview.backgroundColor = UIColor.white.withAlphaComponent(0.88)
        uıview.layer.cornerRadius = 12
        uıview.clipsToBounds = true
        uıview.layer.borderColor = UIColor.darkGray.cgColor
        uıview.layer.borderWidth = 1
        
    
        
    }
    
    
    
    func fetchWeatherData(for city: String){
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        
        
        
        let params : Parameters = [
            "q": city,
            "appid": apiKey,
            "units": "metric"
        ]
        AF.request(urlString,method:.get, parameters:params).response{
            response in
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with:data , options : [] ) as? [String:AnyObject]{
                        print(json)
                        self.updateUI(with: json)
                    }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
            
            
            
            
            
        }
        
    func playAnimation(for condition:String){
        animationView?.removeFromSuperview()
        var animationName :String = ""
        switch condition {
        case "Clear":
            animationName = "sunny"
            case "Clouds":
            animationName = "cloudy"
        case "Rain":
            animationName = "rainy"
        default:
            animationName = "parcalıbulutlu"
        }
        animationView = LottieAnimationView(name:animationName)
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1
        view.insertSubview(animationView!, at: 1)
        animationView?.play()
        
        
    }
        
        
        func updateUI(with json: [String: Any]) {
            
            if let name = json["name"] as? String,
               let main = json["main"] as? [String: Any],
               let temp = main["temp"] as? Double,
               let weatherArray = json["weather"] as? [[String: Any]],
               let weather = weatherArray.first,
               let condition = weather["main"] as? String{
            

                cityLabel.text = name
                temparatureLabel.text = "\(Int(temp)) °C"
                descriptionLabel.text = condition
                cityTextField.text = name

                

                playAnimation(for: condition)
            }
        }
    func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds

        // Geçiş yapılacak renkler (beyazdan senin seçtiğin renge)
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor(red: 34/255.0, green: 170/255.0, blue: 200/255.0, alpha: 0.8).cgColor
        ]

        // Geçiş yönü: yukarıdan aşağıya
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
        
        
        
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            present(alert, animated: true)
        }
    
    func locationWeather(lat: CLLocationDegrees,lon: CLLocationDegrees) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=\(apiKey)"
        
        AF.request(urlString,method: .get).response{
            response in
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data,options: []) as? [String:Any]{
                        print(json)
                        self.updateUI(with: json)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
    }

        
        
    @IBAction func locationButton(_ sender: UIButton) {
        cityTextField.text = ""
        locationManager.requestLocation()

    }
    
}

extension ViewController: CLLocationManagerDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            locationWeather(lat:lat,lon:lon)
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        showAlert(message: "Konum alınamadı")

        print(error.localizedDescription)
    }
}

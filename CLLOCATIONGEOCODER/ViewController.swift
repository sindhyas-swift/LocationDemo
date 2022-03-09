//
//  ViewController.swift
//  CLLOCATIONGEOCODER
//
//  Created by SINDHYA ANOOP on 3/5/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let  ceo = CLGeocoder()
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var country: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }


func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let locations = locations.last{
        locationManager.stopUpdatingLocation()
        let latitude = locations.coordinate.latitude
        let longitude = locations.coordinate.longitude
        let loc = CLLocation(latitude: latitude, longitude: longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:
                    {(placemarks, error) in
                        if (error != nil)
                        {
                            print("reverse geodcode fail: \(error!.localizedDescription)")
                        }
                        let pm = placemarks! as [CLPlacemark]

                        if pm.count > 0 {
                            let pm = placemarks![0]
                            print(pm.country!)
                            print(pm.locality!)

                            DispatchQueue.main.async {

                                self.city.text = pm.locality
                                self.country.text = pm.country

                            }
                            
                        }
                    })
}
}
func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
}
}


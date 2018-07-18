//
//  MapVC.swift
//  GeoPic
//
//  Created by Ashwin Mahesh on 7/17/18.
//  Copyright © 2018 AshwinMahesh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {

    @IBAction func homePushed(_ sender: UIButton) {
        performSegue(withIdentifier: "MapToExploreSegue", sender: "MapToExplore")
    }
    
    @IBAction func searchPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "MapToSearchSegue", sender: "MapToSearch")
    }
    
    @IBOutlet weak var mapView: MKMapView!
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension MapVC:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
        
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        mapView.setRegion(region, animated: true)
        
        self.mapView.showsUserLocation = true
    }
}

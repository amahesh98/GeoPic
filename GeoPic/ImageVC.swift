//
//  ImageVC.swift
//  CoreLocationPractice
//
//  Created by Drew on 7/17/18.
//  Copyright © 2018 Drew. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ImageVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let manager = CLLocationManager()
    var myLongitude = ""
    var myLatitude = ""
    var image_data: String = ""
    
//    Test function to test pulling from server
    @IBAction func buttonPressed(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var locationLabel: UILabel!
    
//    Button Action, sends to server
    @IBAction func postPressed(_ sender: UIButton) {
        print("You are pressing post")
        let image = UIImagePNGRepresentation(imageView.image!)!
        let imageData = image.base64EncodedString(options: .lineLength64Characters)
        let url = URL(string: "http://192.168.1.228:8000/uploadImage/")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let bodyData = "image_data=\(imageData)"
        request.httpBody = bodyData.data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest){
            data, response, error in
            do{
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary{
                    print(jsonResult)
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
//    Choose from photo library
    @IBAction func importPressed(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true) {
        }
    }
    
//    Camera picture
    @IBAction func takePicturePressed(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .camera
        image.allowsEditing = false
        self.present(image, animated: true) {
        }
    }
//    Set picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        } else {
            print("error")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

//Map
extension ImageVC: CLLocationManagerDelegate, UISearchBarDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        myLatitude = String(location.coordinate.latitude)
        myLongitude = String(location.coordinate.longitude)
        print(myLongitude)
        print(myLatitude)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        print(myLocation)
                
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil {
                print("error")
            } else {
                if let place = placemark?[0] {
                    if let checker = place.subThoroughfare{
                        self.locationLabel.text = "\(place.subThoroughfare!), \(place.thoroughfare!), \(place.country!)"
                    }
                }
            }
        }
    }
}


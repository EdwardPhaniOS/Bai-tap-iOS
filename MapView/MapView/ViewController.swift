//
//  ViewController.swift
//  MapView
//
//  Created by iMac_VTCA on 1/8/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var myMapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var locations: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 10.764421, longitude: 106.654638),
        CLLocationCoordinate2D(latitude: 10.765438, longitude: 106.654040),
        CLLocationCoordinate2D(latitude: 10.761348, longitude: 106.655609),
        CLLocationCoordinate2D(latitude: 106.654040, longitude: 106.657428),
        CLLocationCoordinate2D(latitude: 10.761348, longitude: 106.655609)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getCurrentLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.perform(#selector(addPinToMap), with: nil, afterDelay: 1)
        
        getLocation(from: "Viet Nam, Da Nang")
    }
    
    func getCurrentLocation() {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.distanceFilter = 20
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func showCurrentLocation(location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, span:
            MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        myMapView.setRegion(region, animated: true)
        myMapView.showsUserLocation = true
    }
    
    @objc func addPinToMap() {
        
        for location in locations {
            let pin = MKPointAnnotation()
            pin.coordinate = location
            pin.title = "\(location)"
            
            myMapView.addAnnotation(pin)
        }
    }
    
    func getLocation(from string: String) {
        
        let customString = string.lowercased()
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(customString) { (placeMarks, error) in
            
            guard let place = placeMarks?.first else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            if let location = place.location?.coordinate {
                print(location)
            }
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let _ = locations.first else {
            return
        }
        
        if let currentLocation = locations.first?.coordinate {
            showCurrentLocation(location: currentLocation)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error = \(error.localizedDescription)")
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation =  annotation as? MKPointAnnotation {
            
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")

            pinAnnotationView.pinTintColor = .cyan
            pinAnnotationView.image = UIImage(named: "shop_icon")
            pinAnnotationView.isDraggable = true
            
            return pinAnnotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        
        if newState == .ending {
            
            let newLocation = mapView.convert(view.center, toCoordinateFrom: view.superview)
            print(newLocation)
        }
    }
    
    
    
}


//
//  CreateItemVC.swift
//  TodoList
//
//  Created by iMac_VTCA on 1/10/20.
//  Copyright © 2020 iMac_VTCA. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

protocol CreateItemVCDelegate: class {
    func itemDidAdded(item: Item)
    func itemEdited(newItem: Item)
}

class CreateItemVC: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    weak var createItemDelegate: CreateItemVCDelegate?
    var keys = [String]()
    var currentLocation: CLLocationCoordinate2D?
    var currentItem: Item?
    
    let locationManager = CLLocationManager()
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keys = userDefault.object(forKey: "itemKeys") as? [String] ?? []
        
        if let item = currentItem {
            self.titleTextField.text = item.title
            self.descriptionTextField.text = item.description
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getCurrentLocation()
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
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        saveData()
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveData() {
        var userLocation: Location?
        
        if let location = currentLocation {
            let lat = Float(location.latitude)
            let long = Float(location.longitude)
            
            userLocation = Location(latitude: lat, longtitude: long)
        }
        
        let newItem = Item(
            uuid: UUID().uuidString,
            title: self.titleTextField.text!,
            description: descriptionTextField.text!,
            date: Date(),
            location: userLocation)
        
        createItemDelegate?.itemDidAdded(item: newItem)
    }
}

extension CreateItemVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.first?.coordinate {
            showCurrentLocation(location: currentLocation)
            self.currentLocation = currentLocation
        }
    }
}

















        
//        if let item = currentItem {
//
//            let newItem = Item(
//                uuid: item.uuid,
//                title: self.titleTextField.text!,
//                description: descriptionTextField.text!,
//                date: Date(),
//                location: userLocation)
//
//            do {
//                let newItemData = try JSONEncoder().encode(newItem)
//                userDefault.set(newItemData, forKey: newItem.uuid)
//                createItemDelegate?.itemEdited(newItem: newItem)
//
//            } catch {
//                print("Error: \(error)")
//            }
//
//        } else {
//            let newItem = Item(
//                uuid: UUID().uuidString,
//                title: self.titleTextField.text!,
//                description: descriptionTextField.text!,
//                date: Date(),
//                location: userLocation)
//
//            keys.append(newItem.uuid)
//
//            do {
//                let newItemData = try JSONEncoder().encode(newItem)
//                userDefault.set(keys, forKey: "itemKeys")
//                userDefault.set(newItemData, forKey: newItem.uuid)
//
//                createItemDelegate?.itemDidAdded()
//
//            } catch {
//                print("Error: \(error)")
//            }
//        }

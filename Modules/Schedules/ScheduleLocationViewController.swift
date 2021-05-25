//
//  ScheduleLocationViewController.swift
//  Schedules
//
//  Created by Lucas Marques Bigh (P) on 20/04/21.
//

import UIKit
import MapKit
import CoreLocation

class ScheduleLocationViewController: UIViewController {
    
    var mapView: MKMapView!
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
        setupMapView()
    }
    
    private func setupMapView() {
        mapView = MKMapView(frame: view.frame)
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsUserLocation = true
        
        let noLocation =  self.mapView.userLocation.coordinate
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let viewLocation = MKCoordinateRegion(center: noLocation, span: span)
        mapView.setRegion(viewLocation, animated: true)
        mapView.center = view.center
        view.addSubview(mapView)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.addAnnotation(_:)))

        self.mapView.addGestureRecognizer(longPress)
    }
    
    @objc func addAnnotation(_ gestureRecognizer:UIGestureRecognizer)
    {

       if gestureRecognizer.state != .began
        {
          return
        }
         let touchPoint = gestureRecognizer.location(in: self.mapView)
         let newCoordinates = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)

    }
}

extension ScheduleLocationViewController: MKMapViewDelegate {
    
}

extension ScheduleLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0] as CLLocation
        
        print("User latitude: \(userLocation.coordinate.latitude)")
        print("User longitude: \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error)")
    }
}

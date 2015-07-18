//
//  ViewController.swift
//  Maps
//
//  Created by Brad Gray on 7/17/15.
//  Copyright (c) 2015 Brad Gray. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
       locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        var lattitude: CLLocationDegrees = 35.590568
        var longitude: CLLocationDegrees = -77.384937
        var LatDelta: CLLocationDegrees = 0.01
        var longDelta: CLLocationDegrees = 0.01
        var span: MKCoordinateSpan = MKCoordinateSpanMake(LatDelta, longDelta)
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lattitude, longitude)
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: false)
        
        var annontatin = MKPointAnnotation()
        annontatin.coordinate = location
        annontatin.title = "place in South Carolina"
        annontatin.subtitle = "place i've been"
        map.addAnnotation(annontatin)
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        uilpgr.minimumPressDuration = 1
        
        map.addGestureRecognizer(uilpgr)
    }
    
    
    func action(gestureRecognizer: UIGestureRecognizer) {
      
        var touchPoint = gestureRecognizer.locationInView(self.map)
        
        var newCoordinate: CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
        var annontatin = MKPointAnnotation()
        annontatin.coordinate = newCoordinate
        annontatin.title = "new place"
        annontatin.subtitle = "place i've been"
        map.addAnnotation(annontatin)

    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        println(locations)
        
        var userLocation: CLLocation = locations[0] as! CLLocation
        
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        
        var LatDelta: CLLocationDegrees = 0.01
        var longDelta: CLLocationDegrees = 0.01
        var span: MKCoordinateSpan = MKCoordinateSpanMake(LatDelta, longDelta)
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.map.setRegion(region, animated: false)
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


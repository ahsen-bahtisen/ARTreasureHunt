//
//  Fileson.swift
//  ARTreasureHunt
//
//  Created by Ahsen Bahtışen on 22.06.2023.
//
//bunda kaybolmuyor
/*
import UIKit
import SceneKit
import ARKit
import CoreLocation
import MapKit

class ViewController: UIViewController, ARSCNViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let treasure = Treasure()
    var score = 0
    let locationManager = CLLocationManager()
    var treasureLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the Mapview's delegate
        mapView.delegate = self
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Set the location delegate
        locationManager.delegate = self
        
        //ne kadar hassas olsun konumun verisi
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //izin isteme- ne zaman kullanılıyorsa o zaman yer takibi yapılsın
        locationManager.requestWhenInUseAuthorization()
        //kullanıcı verisi alma
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
       

    }
    
    func addObject(location: CLLocation) {
            // Modeli oluştur
            treasure.loadModel()
            
            // Modeli sahneye ekle
            treasure.position = SCNVector3(x: Float(location.coordinate.latitude) * 0, y: Float(location.coordinate.longitude) * 0, z: -1.0)
            sceneView.scene.rootNode.addChildNode(treasure)
            
            // Haritaya ekle
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            mapView.addAnnotation(annotation)
            treasure.treasureAnnotation = annotation
            
            // Haritayı güncelle
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    
    /*func addObject() {
        
        treasure.loadModel()
        
        treasure.position = SCNVector3(x: 0, y: 0, z: -0.1)
       // treasure.scale = SCNVector3(0.06,0.06,0.06) //objeyi küçülttük scale ile
        sceneView.scene.rootNode.addChildNode(treasure) //sahmneye ekleme
        // haritaya ekleme
        let location = CLLocationCoordinate2D(latitude: 38.7194111800447, longitude: 35.514434174711106)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        treasure.treasureAnnotation = annotation
       

    }*/
    
   /* func addObject(node: SCNNode, at location: CLLocationCoordinate2D) {
        node.position = SCNVector3(x: Float(location.latitude), y: 0, z: Float(location.longitude))
        sceneView.scene.rootNode.addChildNode(node)
    }*/

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
           return nil
        } else {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "treasure")
            let image = UIImage(named: "treasureChest")
            annotationView.image = image
            var frame = annotationView.frame
            frame.size.height = 40
            frame.size.width = 40
            annotationView.frame = frame
            return annotationView
        }
    
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.location(in: sceneView)
            
            let hitList = sceneView.hitTest(location, options: nil)
            
            if let hitObject = hitList.first{
                let node = hitObject.node
                    node.removeFromParentNode()
                if let treasureAnnotation = treasure.treasureAnnotation {
                    mapView.removeAnnotation(treasureAnnotation)
                    treasure.treasureAnnotation = nil // Reset the annotation
                }
                    score += 5
                    print(score)
               
            }
        }
    }
    
   /* func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0].coordinate
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }*/
    
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.first else { return }
            
            addObject(location: location)
        }




    
//PUAN GÜNCELLEMESİ
    func updateScoreLabel() {
        //scoreLabel.text = "Puan: \(score)"
        print(score)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

}

*/

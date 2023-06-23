//
//  ViewController.swift
//  ARTreasureHunt
//
//  Created by Ahsen Bahtışen on 14.06.2023.
//

/*import UIKit
import SceneKit
import ARKit
import CoreLocation
import MapKit

class ViewController: UIViewController, ARSCNViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let treasure = Treasure()
    var treasures: [Treasure] = []
    var score = 0
    let locationManager = CLLocationManager()
    
    
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
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
        addObject()
    
    }
    
    func addObject() {
        
        treasure.loadModel()
        
        treasure.position = SCNVector3(x: 0, y: 0, z: -0.1)
       // treasure.scale = SCNVector3(0.06,0.06,0.06) //objeyi küçülttük scale ile
        sceneView.scene.rootNode.addChildNode(treasure) //sahmneye ekleme
        

    }
   

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.location(in: sceneView)
            
            let hitList = sceneView.hitTest(location, options: nil)
            
            if let hitObject = hitList.first{
                let node = hitObject.node
                    node.removeFromParentNode()
                    addObject()
                    score += 5
                    print(score)
               
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //kullanıcının konumunu aldık
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
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

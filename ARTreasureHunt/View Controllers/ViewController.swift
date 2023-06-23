//
//  ViewController.swift
//  ARTreasureHunt
//
//  Created by Ahsen Bahtışen on 14.06.2023.
//

import UIKit
 import SceneKit
 import ARKit
 import CoreLocation
 import MapKit

    //MARK: Protocol
protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocation)
    func didFailWithError(_ error: Error)
}
  
  class ViewController: UIViewController, ARSCNViewDelegate, LocationManagerDelegate, MKMapViewDelegate {

    //MARK: Outlets
     @IBOutlet var sceneView: ARSCNView!
     @IBOutlet weak var mapView: MKMapView!
     @IBOutlet weak var distanceLabel: UILabel!
     
    //MARK: Properties
     let treasure = Treasure()
     var treasures = [Treasure]()
     var score = 0
     var treasureCount = 0
     let locationManager = LocationManager()
     let treasureLocations = TreasureLocations()
     
    //MARK: Lifecycle
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
         
         mapView.showsUserLocation = true
         
         locationManager.startUpdatingLocation()
         
         let defaults = UserDefaults.standard
         
         if let score = defaults.value(forKey: "UserScore") as? Int {
             self.score = score
         }
                 
         if let treasureCount = defaults.value(forKey: "TreasureCount") as? Int {
             self.treasureCount = treasureCount
         }
     }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         
         // Create a session configuration
         let configuration = ARWorldTrackingConfiguration()
         
         // Run the view's session
         sceneView.session.run(configuration)
         
         for location in treasureLocations.locations {
                    let treasure = Treasure()
                    treasures.append(treasure)
                    addObject(treasure: treasure, location: CLLocation(latitude: location.latitude, longitude: location.longitude))
                }
         
         //Allows overlays to be cleared when a click on the map is detected
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
         mapView.addGestureRecognizer(tapGesture)
     }
    
    @objc func handleMapTap(_ gesture: UITapGestureRecognizer) {
        mapView.removeOverlays(mapView.overlays)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
        
        locationManager.stopUpdatingLocation()
    }

      var userLocation: CLLocation?

      func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          if userLocation == nil {
              userLocation = locations.first
          }
      }

    
    //MARK: Methods
     func addObject(treasure: Treasure, location: CLLocation) {
         
         treasure.loadModel()
         
         guard let treasureNode = treasure.treasureNode else { return }
         
         // Set the position for each treasure
         switch treasures.firstIndex(of: treasure)! {
         case 0:
             treasureNode.position = SCNVector3(x: Float(location.coordinate.latitude) * 0, y: Float(location.coordinate.longitude) * 0, z: -1.0)
         case 1:
             treasureNode.position = SCNVector3(x: Float(location.coordinate.latitude) * 0.5, y: Float(location.coordinate.longitude) * 0.5, z: -1.0)
         case 2:
             treasureNode.position = SCNVector3(x: Float(location.coordinate.latitude), y: Float(location.coordinate.longitude), z: -1.0)
         default:
             treasureNode.position = SCNVector3(x: Float(location.coordinate.latitude), y: Float(location.coordinate.longitude), z: -1.0)
         }
         
         //The model is added to the scene
         sceneView.scene.rootNode.addChildNode(treasureNode)
         treasure.treasureNode = treasureNode
         
         
         // Add the treasure to the map
         let annotation = MKPointAnnotation()
         annotation.coordinate = location.coordinate
         mapView.addAnnotation(annotation)
         treasure.treasureAnnotation = annotation
         
     }
    
     //LocationManager functions
    func didUpdateLocation(_ location: CLLocation) {
         let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
         mapView.setRegion(region, animated: true)
     }
    
    func didFailWithError(_ error: Error) {
        print("Location Manager Error: \(error.localizedDescription)")
    }
    
    
      //Saves the user score and the number of treasures found in userDefaults
      func saveScoreAndTreasureCount() {
          let defaults = UserDefaults.standard
          defaults.set(score, forKey: "UserScore")
          defaults.set(treasureCount, forKey: "TreasureCount")
      }

     
    //when the user clicks on the model user found, the model disappears and the warning message is shown
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         super.touchesBegan(touches, with: event)
         
         if let touch = touches.first {
             let location = touch.location(in: sceneView)
             let hitList = sceneView.hitTest(location, options: nil)
             
             if let hitObject = hitList.first {
                 let node = hitObject.node
                 let parentNode = node.parent
                 parentNode?.removeFromParentNode()
                 
                 if let treasure = treasures.first(where: { $0.treasureNode == parentNode }),
                    let treasureAnnotation = treasure.treasureAnnotation {
                     mapView.removeAnnotation(treasureAnnotation)
                 }
                 score += 5
                 treasureCount += 1
                 print(score)
                 print(treasureCount)
                 saveScoreAndTreasureCount()
                 
                 //Show allert
                 let alert = UIAlertController(title: "Congratulations!", message: "You found a treasure. Look at the map to find other treasures.", preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                 self.present(alert, animated: true, completion: nil)
             }
         }
     }
     
    
    //Customizes pins
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
     
    //Draws route from user location to selected treasure location and displays distance
     func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
         mapView.removeOverlays(mapView.overlays)
         
         guard let annotation = view.annotation else { return }
         
         let pinLocation = MKPlacemark(coordinate: annotation.coordinate)
         

         if let userLocation = locationManager.currentLocation {
             let userPlacemark = MKPlacemark(coordinate: userLocation.coordinate)
             
             let distanceInMeters = userLocation.distance(from: CLLocation(latitude: pinLocation.coordinate.latitude, longitude: pinLocation.coordinate.longitude))
                     let distanceInKilometers = distanceInMeters / 1000
             let formattedDistance = String(format: "%.1f", distanceInKilometers)
             distanceLabel.text = "\(formattedDistance) km"
             
             let directionRequest = MKDirections.Request()
             directionRequest.source = MKMapItem(placemark: userPlacemark)
             directionRequest.destination = MKMapItem(placemark: pinLocation)
             directionRequest.transportType = .automobile // or .walking, .transit
             
             let directions = MKDirections(request: directionRequest)
             directions.calculate { (response, error) in
                 guard let response = response else {
                     print("Hata: \(error?.localizedDescription ?? "Bilinmeyen hata")")
                     return
                 }
                 
                 let route = response.routes[0]
                 mapView.addOverlay(route.polyline, level: .aboveRoads)
                 
                 let rect = route.polyline.boundingMapRect
                 mapView.setRegion(MKCoordinateRegion(rect), animated: true)
             }
         } else {
             print("Kullanıcının konumu alınamadı.")
         }
         

     }

     func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         if overlay is MKPolyline {
             let renderer = MKPolylineRenderer(overlay: overlay)
             renderer.strokeColor = UIColor.blue
             renderer.lineWidth = 3.0
             return renderer
         }
         
         return MKOverlayRenderer()
     }
    
    //When clicking elsewhere on the map, the drawn route and km information do not appear
     func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
         distanceLabel.text = ""
         mapView.removeOverlays(mapView.overlays)
     }
     
    //MARK: Actions
     @IBAction func mapClosed(_ sender: Any) {
         mapView.isHidden = !mapView.isHidden
         
     }
 }

//
//  MapViewController.swift
//  MoviesLib
//
//  Created by Matheus Lopes on 13/09/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private lazy var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        requestAuthorization()
    }
    
    private func setup() {
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    private func requestAuthorization() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

}

extension MapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let request = MKLocalSearch.Request()
        request.region = mapView.region
        request.naturalLanguageQuery = searchBar.text
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response else { return }
            
            self.mapView.removeAnnotations(self.mapView.annotations)
            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                annotation.subtitle = item.url?.absoluteString
                self.mapView.addAnnotation(annotation)
            }
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 8
        renderer.strokeColor = .systemPurple
        
        return renderer
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        /* Configurando visualização por câmera, trazendo-a próxima ao usuário
        
        let camera = MKMapCamera()
        camera.centerCoordinate = mapView.userLocation.coordinate
        camera.pitch = 80
        camera.altitude = 100
        mapView.setCamera(camera, animated: true)
        */
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: view.annotation!.coordinate))
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response,
                  let route = response.routes.first else { return }
            
            print("Nome: ", route.name)
            print("Distância total: ", route.distance)
            print("Duração: ", route.expectedTravelTime)
            
            for step in route.steps {
                print("Em \(step.distance) metros, \(step.instructions)")
            }
                    
            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
        
        }
    }
}

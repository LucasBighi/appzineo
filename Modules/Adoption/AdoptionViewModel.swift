//
//  AdoptionViewModel.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 26/05/21.
//

import Foundation
import CoreLocation

class AdoptionViewModel: NSObject {
    
    private var locationManager: CLLocationManager
    var adoptions = [Adoption]()
    var selectedAdoption: Adoption?
    
    private override init() {
        self.locationManager = CLLocationManager()
        super.init()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    static let shared = AdoptionViewModel()
    
    func getAdoptions(_ completion: @escaping() -> Void) {
        Database.default.get(Adoption.self) { result in
            switch result {
            case .success(let adoptions):
                self.adoptions = adoptions
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPet(ofAdoption adoption: Adoption?) -> Pet? {
        return PetViewModel.shared.pets.first(where: { $0.id == adoption?.petId })
    }
    
    func getOwner(ofAdoption adoption: Adoption?) -> Owner? {
        return OwnerViewModel.shared.owners.first(where: { $0.id == adoption?.advertiserId })
    }
    
    func currentUserLocation() -> CLLocation? {
        
        return locationManager.location
    }
    
    func getUserReverseGeocodeLocation(_ completion: @escaping(CLPlacemark?) -> Void) {
        guard let userLocation = currentUserLocation() else { return }
        CLGeocoder().reverseGeocodeLocation(userLocation, preferredLocale: Locale(identifier: "pt-BR")) { placemarks, error in
            if let error = error {
                print(error)
                completion(nil)
            } else {
                completion(placemarks?.first)
            }
        }
    }
    
    func showAdoptionDetail(at indexPath: IndexPath, at viewController: AdoptionViewController) {
        self.selectedAdoption = adoptions[indexPath.row]
        viewController.navigationController?.pushViewController(AdoptionDetailViewController(), animated: true)
    }
    
    func newAdoption(with pet: Pet? = nil, at viewController: AdoptionViewController) {
        
    }
}

extension AdoptionViewModel: CLLocationManagerDelegate {
    
}

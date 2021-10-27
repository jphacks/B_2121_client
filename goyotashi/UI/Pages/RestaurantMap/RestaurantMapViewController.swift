//
//  RestaurantMapViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit
import MapKit

class RestaurantMapViewController: UIViewController, ViewConstructor {

    // MARK: - Variables
    private let location: Location
    private let placeName: String

    // MARK: - Views
    private let mapView = MKMapView()
    private let openNativeMapButton = OpenMapButton(mapAppType: .nativeMap).then {
        $0.layer.shadowColor = Color.gray01.cgColor
        $0.layer.shadowOffset = .zero
        $0.layer.shadowOpacity = 0.6
        $0.layer.shadowRadius = 4
    }
    private let openGoogleMapButton = OpenMapButton(mapAppType: .googleMap).then {
        $0.layer.shadowColor = Color.gray01.cgColor
        $0.layer.shadowOffset = .zero
        $0.layer.shadowOpacity = 0.6
        $0.layer.shadowRadius = 4
    }

    // MARK: - Initializers
    init(placeName: String, location: Location) {
        self.location = location
        self.placeName = placeName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewConstraints()
        setMap(location: location)
    }

    // MARK: - Setup Methods
    func setupViews() {
        title = placeName
        view.addSubview(mapView)
        view.addSubview(openNativeMapButton)
        view.addSubview(openGoogleMapButton)
    }

    func setupViewConstraints() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        openNativeMapButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview().inset(64)
        }
        openGoogleMapButton.snp.makeConstraints {
            $0.left.equalTo(openNativeMapButton.snp.right).offset(16)
            $0.bottom.equalToSuperview().inset(64)
        }
    }

    private func setMap(location: Location) {
        let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(location.latitude), longitude: CLLocationDegrees(location.longitude))
        mapView.setCenter(center, animated: false)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: center, span: span)
        mapView.region = region
        let pointAnnotation: MKPointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = center
        pointAnnotation.title = placeName
        mapView.addAnnotation(pointAnnotation)
    }
}

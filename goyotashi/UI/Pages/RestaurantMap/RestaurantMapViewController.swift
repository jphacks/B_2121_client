//
//  RestaurantMapViewController.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/27.
//

import UIKit
import MapKit
import RxSwift

class RestaurantMapViewController: UIViewController, ViewConstructor {

    // MARK: - Variables
    private let geoPoint: GeoPoint
    private let restaurantName: String

    var disposeBag = DisposeBag()

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
    init(restaurantName: String, geoPoint: GeoPoint) {
        self.geoPoint = geoPoint
        self.restaurantName = restaurantName
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
        setMap(geoPoint: geoPoint)
        bind()
    }

    // MARK: - Setup Methods
    func setupViews() {
        title = restaurantName
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
            $0.bottom.equalToSuperview().inset(32)
        }
        openGoogleMapButton.snp.makeConstraints {
            $0.left.equalTo(openNativeMapButton.snp.right).offset(16)
            $0.bottom.equalToSuperview().inset(32)
        }
    }

    private func setMap(geoPoint: GeoPoint) {
        let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(geoPoint.latitude), longitude: CLLocationDegrees(geoPoint.longitude))
        mapView.setCenter(center, animated: false)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: center, span: span)
        mapView.region = region
        let pointAnnotation: MKPointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = center
        pointAnnotation.title = restaurantName
        mapView.addAnnotation(pointAnnotation)
    }

    private func bind() {
        openNativeMapButton.rx.tap
            .bind { [weak self] _ in
                let daddr = NSString(format: "%f,%f", self?.geoPoint.latitude ?? "", self?.geoPoint.longitude ?? "")
                let urlString = "http://maps.apple.com/?daddr=\(daddr)&dirflg=w"
                if let url = URL(string: urlString) {
                    UIApplication.shared.open(url)
                }
            }
            .disposed(by: disposeBag)

        openGoogleMapButton.rx.tap
            .bind { [weak self] _ in
                if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
                    let daddr = NSString(format: "%f,%f", self?.geoPoint.latitude ?? "", self?.geoPoint.longitude ?? "")
                    let urlStr: String = "comgooglemaps://?daddr=\(daddr)&directionsmode=walking&zoom=14"
                    if let url = URL(string: urlStr) {
                        UIApplication.shared.open(url)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}

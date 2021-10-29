//
//  RestaurantHeaderView.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/26.
//

import UIKit
import ReactorKit
import MapKit

final class RestaurantHeaderView: UIView, View, ViewConstructor {
    struct Const {
        static let aspectRatio: CGFloat = 1.42
        static let imageWidth: CGFloat = DeviceSize.screenWidth
        static let imageHeight: CGFloat = imageWidth / aspectRatio
        static let mapViewHeight: CGFloat = 120
    }

    // MARK: - Variables
    var disposeBag = DisposeBag()

    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = R.image.dish()
    }

    private let restaurantNameLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 20, color: Color.gray01)
        $0.numberOfLines = 0
    }

    private let restaurantDescriptionLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 13, color: Color.gray03)
        $0.numberOfLines = 0
    }

    let addRestaurantButton = AddRestaurantButton()

    private let restaurantInformationView = RestaurantInformationView()

    let mapView = MKMapView()

    private let openNativeMapButton = OpenMapButton(mapAppType: .nativeMap)
    private let openGoogleMapButton = OpenMapButton(mapAppType: .googleMap)

    private let separator = UIView().then {
        $0.backgroundColor = Color.gray06
    }

    private let otherGroupTitleLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 18, color: Color.gray01)
        $0.text = "このお店を含むほかのグループ"
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViews()
        setupViewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods
    func setupViews() {
        addSubview(imageView)
        addSubview(restaurantNameLabel)
        addSubview(restaurantDescriptionLabel)
        addSubview(addRestaurantButton)
        addSubview(restaurantInformationView)
        addSubview(mapView)
        addSubview(openNativeMapButton)
        addSubview(openGoogleMapButton)
        addSubview(separator)
        addSubview(otherGroupTitleLabel)
    }

    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.width.equalTo(Const.imageWidth)
            $0.height.equalTo(Const.imageHeight)
        }
        restaurantNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalTo(addRestaurantButton.snp.left).offset(-16)
        }
        restaurantDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(restaurantNameLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalTo(addRestaurantButton.snp.left).offset(-16)
        }
        addRestaurantButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.right.equalToSuperview().inset(16)
        }
        restaurantInformationView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(restaurantDescriptionLabel.snp.bottom).offset(32)
            $0.top.greaterThanOrEqualTo(addRestaurantButton.snp.bottom).offset(32)
            $0.left.right.equalToSuperview()
        }
        mapView.snp.makeConstraints {
            $0.top.equalTo(restaurantInformationView.snp.bottom).offset(32)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(Const.mapViewHeight)
        }
        openNativeMapButton.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
        }
        openGoogleMapButton.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(16)
            $0.left.equalTo(openNativeMapButton.snp.right).offset(16)
        }
        separator.snp.makeConstraints {
            $0.top.equalTo(openNativeMapButton.snp.bottom).offset(48)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        otherGroupTitleLabel.snp.makeConstraints {
            $0.top.equalTo(separator).offset(48)
            $0.left.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
        }
    }

    // MARK: - Bind Method
    func bind(reactor: RestaurantReactor) {
        // Action
        openNativeMapButton.rx.tap
            .bind { _ in
                guard let geoPoint = reactor.currentState.restaurant?.geoPoint else { return }
                let daddr = NSString(format: "%f,%f", geoPoint.latitude, geoPoint.longitude)
                let urlString = "http://maps.apple.com/?daddr=\(daddr)&dirflg=w"
                if let url = URL(string: urlString) {
                    UIApplication.shared.open(url)
                }
            }
            .disposed(by: disposeBag)

        openGoogleMapButton.rx.tap
            .bind { _ in
                if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
                    guard let geoPoint = reactor.currentState.restaurant?.geoPoint else { return }
                    let daddr = NSString(format: "%f,%f", geoPoint.latitude, geoPoint.longitude)
                    let urlStr: String = "comgooglemaps://?daddr=\(daddr)&directionsmode=walking&zoom=14"
                    if let url = URL(string: urlStr) {
                        UIApplication.shared.open(url)
                    }
                }
            }
            .disposed(by: disposeBag)

        // State
        reactor.state.map { $0.restaurant?.imageUrl }
            .distinctUntilChanged()
            .filterNil()
            .bind { [weak self] urlString in
                self?.imageView.kf.setImage(with: URL(string: urlString), placeholder: R.image.dish())
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.restaurant?.name }
            .distinctUntilChanged()
            .bind(to: restaurantNameLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.restaurant?.description }
            .distinctUntilChanged()
            .bind(to: restaurantDescriptionLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.restaurant }
            .distinctUntilChanged()
            .filterNil()
            .bind { [weak self] restaurant in
                self?.restaurantInformationView.configure(
                    restaurantName: restaurant.name,
                    address: restaurant.address,
                    phoneNumber: restaurant.phoneNumber,
                    openingHours: restaurant.openingHours
                )
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.restaurant?.geoPoint }
            .distinctUntilChanged()
            .filterNil()
            .bind { [weak self] geoPoint in
                self?.setMap(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
            }
            .disposed(by: disposeBag)
    }

    private func setMap(latitude: Double?, longitude: Double?) {
        guard let latitude = latitude, let longitude = longitude else {
            return
        }
        let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        mapView.setCenter(center, animated: false)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: center, span: span)
        mapView.region = region
        let pointAnnotation: MKPointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = center
        mapView.addAnnotation(pointAnnotation)
    }
}

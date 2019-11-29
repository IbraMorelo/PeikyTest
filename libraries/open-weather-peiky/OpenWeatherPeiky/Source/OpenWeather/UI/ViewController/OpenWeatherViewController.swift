//
//  OpenWeatherViewController.swift
//  OpenWeatherPeiky
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

import CoreLocation

enum TypeOfSearch: Int {
    case city
    case location
    case current
}

protocol OpenWeatherViewOutput {
    func requestWeatherCity(name: String,
                            completionHandler: @escaping (_ openWeatherDetail: OpenWeatherDetail) -> Void,
                            onError: @escaping () -> Void)
    func requestWeatherLocation(lat: String,
                                lon: String,
                                completionHandler: @escaping (_ openWeatherDetail: OpenWeatherDetail) -> Void,
                                onError: @escaping () -> Void)
}

final class OpenWeatherViewController: UIViewController {
    
    @IBOutlet private weak var typeOfSearchControl: UISegmentedControl! {
        didSet {
            typeOfSearchControl.setTitle("Ciudad", forSegmentAt: 0)
            typeOfSearchControl.setTitle("Localización", forSegmentAt: 1)
            typeOfSearchControl.setTitle("Actual", forSegmentAt: 2)
        }
    }
    @IBOutlet private weak var fieldCity: UITextField!
    @IBOutlet private weak var fieldLocationLat: UITextField!
    @IBOutlet private weak var fieldLocationLon: UITextField!
    @IBOutlet private weak var stackviewLocation: UIStackView!
    @IBOutlet private weak var searchBtn: UIButton! {
        didSet {
            searchBtn.backgroundColor = #colorLiteral(red: 0, green: 0.534819901, blue: 0.9057584405, alpha: 1)
            searchBtn.setTitle("Buscar", for: .normal)
            searchBtn.setTitleColor(.white, for: .normal)
            searchBtn.layer.cornerRadius = searchBtn.frame.height / 2
        }
    }
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var presenter: OpenWeatherViewOutput
    private var typeOfSearch: TypeOfSearch = .city
    private var openWeatherDetail: [OpenWeatherDetail] = []
    private let heightCell: CGFloat = 50.0
    private let locationManager = CLLocationManager()
    
    init(presenter: OpenWeatherViewOutput) {
        self.presenter = presenter
        super.init(nibName: String(describing: OpenWeatherViewController.self),
                   bundle: bundleForXib(type: OpenWeatherViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not implemented")
    }
    
    override func viewDidLoad() {
        setupCollection()
        locationManager.delegate = self
    }
}

extension OpenWeatherViewController {
    @IBAction func typeOfSearchChanged(_ sender: Any) {
        resetFields()
        switch TypeOfSearch(rawValue: typeOfSearchControl.selectedSegmentIndex)
        {
        case .city:
            fieldCity.isHidden = false
            stackviewLocation.isHidden = true
            typeOfSearch = .city
        case .location:
            fieldCity.isHidden = true
            stackviewLocation.isHidden = false
            typeOfSearch = .location
        case .current:
            getCurrentLocation()
            fieldCity.isHidden = true
            stackviewLocation.isHidden = false
            typeOfSearch = .current
        case .none:
            break
        }
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        switch typeOfSearch {
        case .city:
            presenter.requestWeatherCity(name: fieldCity.text ?? "", completionHandler: { [weak self] data in
                self?.addNewItem(data)
            }, onError: { [weak self] in
                self?.showAlertError()
            })
        default:
            requestWeatherLocation(fieldLocationLat.text ?? "", lon: fieldLocationLon.text ?? "")
        }
    }
    
    func registerCells() {
        let nibName = String(describing: SectionsCellView.self)
        let nib = UINib(nibName: nibName, bundle: .openWeatherPeikyBundle)
        collectionView.register(nib, forCellWithReuseIdentifier: nibName)
    }
    
    func setupCollection() {
        collectionView.contentInsetAdjustmentBehavior = .never
        registerCells()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentSize.width = collectionView.bounds.width * 2
    }
    
    func addNewItem(_ item: OpenWeatherDetail) {
        openWeatherDetail.append(item)
        collectionView.reloadData()
    }
    
    func showAlertError() {
        let alert = UIAlertController(title: "Datos no encontrados", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func getCurrentLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestLocation()
        }
    }
    
    func requestWeatherLocation(_ lat: String, lon: String) {
        presenter.requestWeatherLocation(lat: lat,
                                         lon: lon,
                                         completionHandler: { [weak self] data in
            self?.addNewItem(data)
        }, onError: { [weak self] in
            self?.showAlertError()
        })
    }
    
    func resetFields() {
        fieldLocationLon.text = ""
        fieldLocationLat.text = ""
        fieldCity.text = ""
    }
}

extension OpenWeatherViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return openWeatherDetail.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SectionsCellView = collectionView.reuse(at: indexPath)
        let data = openWeatherDetail[indexPath.row]
        cell.setup(data)
        return cell
        
    }
}

extension OpenWeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: heightCell)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
}

extension OpenWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            fieldLocationLat.text = "\(location.coordinate.latitude)"
            fieldLocationLon.text = "\(location.coordinate.longitude)"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

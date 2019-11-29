//
//  OpenWeatherViewController.swift
//  OpenWeatherPeiky
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

enum TypeOfSearch: Int {
    case city
    case location
}

protocol OpenWeatherViewOutput {
    func didLoad()
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
        }
    }
    @IBOutlet private weak var fieldCity: UITextField!
    @IBOutlet private weak var fieldLocationLat: UITextField!
    @IBOutlet private weak var fieldLocationLon: UITextField!
    @IBOutlet private weak var stackviewLocation: UIStackView!
    @IBOutlet private weak var searchBtn: UIButton! {
        didSet {
            searchBtn.backgroundColor = #colorLiteral(red: 0, green: 0.534819901, blue: 0.9057584405, alpha: 1)
            searchBtn.setTitleColor(.white, for: .normal)
            searchBtn.layer.cornerRadius = searchBtn.frame.height / 2
        }
    }
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var presenter: OpenWeatherViewOutput
    private var typeOfSearch: TypeOfSearch = .city
    private var openWeatherDetail: [OpenWeatherDetail] = []
    
    init(presenter: OpenWeatherViewOutput) {
        self.presenter = presenter
        super.init(nibName: String(describing: OpenWeatherViewController.self),
                   bundle: bundleForXib(type: OpenWeatherViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not implemented")
    }
    
    override func viewDidLoad() {
        presenter.didLoad()
        setupCollection()
    }
}

extension OpenWeatherViewController {
    @IBAction func typeOfSearchChanged(_ sender: Any) {
        switch TypeOfSearch(rawValue: typeOfSearchControl.selectedSegmentIndex)
        {
        case .city:
            fieldCity.isHidden = false
            stackviewLocation.isHidden = true
            fieldLocationLat.text = ""
            fieldLocationLon.text = ""
            typeOfSearch = .city
        case .location:
            fieldCity.isHidden = true
            fieldCity.text = ""
            stackviewLocation.isHidden = false
            typeOfSearch = .location
        default:
            break
        }
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        switch typeOfSearch {
        case .city:
            presenter.requestWeatherCity(name: fieldCity.text ?? "", completionHandler: { [weak self] data in
                self?.addNewItem(data)
            }, onError: {
                
            })
        case .location:
            presenter.requestWeatherLocation(lat: fieldLocationLat.text ?? "",
                                             lon: fieldLocationLon.text ?? "",
                                             completionHandler: { [weak self] data in
                                                self?.addNewItem(data)
            }, onError: {
                
            })
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
        let height: CGFloat = 50.0
        return CGSize(width: width, height: height)
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

import UIKit

protocol ListFlightsViewControllerDisplay: AnyObject {
    func showFlights(_ flights: Flights)
    func showError(_ text: String)
}

final class FlightsHistoryViewController: BaseViewController {
    
    
    //MARK: - properties
    private var collectionView: UICollectionView!
    
    var flightsHistory = [Flight]()
    private var viewModel: FlightsHistoryViewModelProtocol
    
    
    //MARK: - setup
    init(viewModel: FlightsHistoryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel.output = self
        loadData()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 40, height: 80)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(cellType: FlightsHistoryViewCell.self)
        
        view.addSubview(collectionView)
    }
    
    func loadData() {
        viewModel.loadFlights()
    }
}

extension FlightsHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FlightStatus.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FlightsHistoryViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let flightStatus = FlightStatus.allCases[indexPath.row]
        let image = UIImage(named: flightStatus.imageName)
        let text = flightStatus.text
        cell.configure(image: image, text: text)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !flightsHistory.isEmpty else {
            let alert = UIAlertController(title: "Nenhum Voo Encontrado",
                                          message: "Atualmente não há voos disponíveis.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let selectedFlightStatus = FlightStatus.allCases[indexPath.row]
        
        switch selectedFlightStatus {
        case .allFlights:
            let filteredListVC = FlightsFilteredListViewController(flightsHistory: self.flightsHistory)
            self.navigationController?.pushViewController(filteredListVC, animated: true)
        case .completedFlight:
            print(FlightStatus.completedFlight.text)
            
        case .cancelledFlight:
            print(FlightStatus.cancelledFlight.text)
        case .delayedFlight:
            print(FlightStatus.delayedFlight.text)
        case .onTimeFlight:
            print(FlightStatus.onTimeFlight.text)
        case .ongoingFlight:
            print(FlightStatus.ongoingFlight.text)
        }
    }
    
}

extension FlightsHistoryViewController: ListFlightsViewControllerDisplay {
    func showFlights(_ flights: Flights) {
        self.flightsHistory = flights.flights
        collectionView.reloadData()
    }
    
    func showError(_ text: String) {
        let alert = UIAlertController(title: "Ops, ocorreu um erro", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}

enum FlightStatus: CaseIterable {
    case allFlights
    case completedFlight
    case cancelledFlight
    case delayedFlight
    case onTimeFlight
    case ongoingFlight
    
    var imageName: String {
        switch self {
        case .allFlights:
            return "all_flights"
        case .completedFlight:
            return "completed_flight"
        case .cancelledFlight:
            return "cancelled_flight"
        case .delayedFlight:
            return "delayed_flight"
        case .onTimeFlight:
            return "on_time_flight"
        case .ongoingFlight:
            return "ongoing_flights"
        }
    }
    
    var text: String {
        switch self {
        case .allFlights:
            return "Todos os Voos"
        case .completedFlight:
            return "Voos Concluídos"
        case .cancelledFlight:
            return "Voos Cancelados"
        case .delayedFlight:
            return "Voos Atrasados"
        case .onTimeFlight:
            return "Voos no Horário"
        case .ongoingFlight:
            return "Voos em Andamento"
        }
    }
}

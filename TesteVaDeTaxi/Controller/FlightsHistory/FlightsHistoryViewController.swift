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
    
    func navigateToFilteredList(for status: FlightStatus) {
        let filteredFlights: [Flight]
        let title: String
        
        switch status {
        case .allFlights:
            filteredFlights = self.flightsHistory
            title = "Todos os Voos"
        case .completedFlight:
            filteredFlights = self.flightsHistory.filter { $0.status == .concluido }
            title = "Voos concluídos"
        case .cancelledFlight:
            filteredFlights = self.flightsHistory.filter { $0.status == .cancelado }
            title = "Voos cancelados"
        case .delayedFlight:
            filteredFlights = self.flightsHistory.filter { $0.completionStatus == .atrasou }
            title = "Voos atrasados"
        case .onTimeFlight:
            filteredFlights = self.flightsHistory.filter { $0.completionStatus == .noHorario }
            title = "Voos no horário"
        case .ongoingFlight:
            filteredFlights = self.flightsHistory.filter { $0.status == .emAndamento }
            title = "Voos em andamento"
        }
        
        let filteredListVC = FlightsFilteredListViewController(flightsHistory: filteredFlights)
        filteredListVC.title = title
        self.navigationController?.pushViewController(filteredListVC, animated: true)
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
        
        navigateToFilteredList(for: selectedFlightStatus)
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

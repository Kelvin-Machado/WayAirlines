import Foundation


protocol FlightsHistoryViewModelProtocol {
    var output: ListFlightsViewControllerDisplay? { get set }
    func loadFlights()
}

final class FlightsHistoryViewModel {
    private let service: FlightsHistoryServiceProtocol
    
    weak var output: ListFlightsViewControllerDisplay?

    init(service: FlightsHistoryServiceProtocol) {
        self.service = service
    }

    private func handle(result: Result<Flights, ServiceError>) {
        switch result {
        case .success(let flights):
            DispatchQueue.main.async { [weak self] in
                self?.output?.showFlights(flights)
            }
        case .failure(let error):
            DispatchQueue.main.async { [weak self] in
                self?.output?.showError(error.localizedDescription)
            }
        }
    }

}

extension FlightsHistoryViewModel: FlightsHistoryViewModelProtocol {
    func loadFlights() {
        service.fetchFlightsHistory { [weak self] result in
            self?.handle(result: result)
        }
    }
}

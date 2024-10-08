@testable import TesteVaDeTaxi

final class FlightsHistoryViewControllerSpy: ListFlightsViewControllerDisplay {
    enum CalledMethods: Equatable {
        case showFlights(_ contacts: Flights)
        case showError(_ text: String)
    }

    private(set) var calledMethods = [CalledMethods]()
    
    func showFlights(_ flights: TesteVaDeTaxi.Flights) {
        calledMethods.append(.showFlights(flights))
    }
    
    func showError(_ text: String) {
        calledMethods.append(.showError(text))
    }
    
}

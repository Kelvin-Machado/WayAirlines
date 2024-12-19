import UIKit

final class FlightsHistoryCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startCoordinator() {
    }
}

extension FlightsHistoryCoordinator: FlightsHistoryCoordinatorProtocol {
    func navigateToFilteredList(for status: FlightStatus, with flightsHistory: [Flight]) {
        let result = FlightsFilteredListFactory.makeFilteredFlights(for: status, with: flightsHistory)
        
        let filteredListVC = FlightsFilteredListViewController(flightsHistory: result.flights)
        filteredListVC.title = result.title
        
        navigationController.pushViewController(filteredListVC, animated: true)
    }
}


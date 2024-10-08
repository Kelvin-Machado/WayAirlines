import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func startCoordinator()
}

protocol HomeCoordinatorProtocol: AnyObject {
    func navigateToFlightsHistory()
}

protocol FlightsHistoryCoordinatorProtocol: AnyObject {
    func navigateToFilteredList(for status: FlightStatus, with flightsHistory: [Flight])
}

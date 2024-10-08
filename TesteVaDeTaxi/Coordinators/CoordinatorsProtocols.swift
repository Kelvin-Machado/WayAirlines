import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func startCoordinator()
}

protocol HomeCoordinatorProtocol: AnyObject {
    func navigateToFlightsHistory()
}

protocol FlightsHistoryCoordinatorProtocol: AnyObject {
    func navigateToFilteredList(flights: [Flight], title: String)
}

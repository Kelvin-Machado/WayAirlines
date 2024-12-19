import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var flightsHistoryCoordinator: FlightsHistoryCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startCoordinator() {
        let viewController = HomeViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func navigateToFlightsHistory() {
        flightsHistoryCoordinator = FlightsHistoryCoordinator(navigationController: navigationController)
        let service = FlightsHistoryService(client: APIClient())
        let viewModel = FlightsHistoryViewModel(service: service)
        let flightsHistoryVC = FlightsHistoryViewController(viewModel: viewModel, coordinator: flightsHistoryCoordinator!)
        flightsHistoryVC.title = "Histórico de Voos"
        navigationController.pushViewController(flightsHistoryVC, animated: true)
    }
}

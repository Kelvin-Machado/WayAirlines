import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startCoordinator() {
        let viewController = HomeViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func navigateToFlightsHistory() {
        let service = FlightsHistoryService(client: APIClient())
        let viewModel = FlightsHistoryViewModel(service: service)
        let flightsHistoryVC = FlightsHistoryViewController(viewModel: viewModel)
        flightsHistoryVC.title = "Histórico de Voos"
        navigationController.pushViewController(flightsHistoryVC, animated: true)
    }
}

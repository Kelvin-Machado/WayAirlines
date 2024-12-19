@testable import WayAirlines

final class FlightsHistoryServiceSpy: FlightsHistoryServiceProtocol {
    var recievedResult: Result<Flights, ServiceError> = .failure(.invalidData)

    private(set) var fetchFlightsCount = 0
    
    func fetchFlightsHistory(completion: @escaping (Result<WayAirlines.Flights, WayAirlines.ServiceError>) -> Void) {
        fetchFlightsCount += 1
        completion(recievedResult)
    }
    
}

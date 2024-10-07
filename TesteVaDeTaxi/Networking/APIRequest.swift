import Foundation

private let apiURL = "https://flighthistory.free.beeceptor.com/flights/history"

enum ServiceError: Error {
    case generic(Error)
    case invalidUrl
    case invalidData
}

protocol FlightsHistoryServiceProtocol {
    func fetchFlightsHistory(completion: @escaping (Result<Flights, ServiceError>) -> Void)
}

final class FlightsHistoryService: FlightsHistoryServiceProtocol {
    private let client: APIClientProtocol

    init(client: APIClientProtocol) {
        self.client = client
    }

    func fetchFlightsHistory(completion: @escaping (Result<Flights, ServiceError>) -> Void) {
        guard let api = URL(string: apiURL) else {
            return completion(.failure(.invalidUrl))
        }

        client.requestGet(url: api) { result in
            switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode(Flights.self, from: data)

                        completion(.success(decoded))
                    } catch let error {
                        completion(.failure(.generic(error)))
                    }
                case .failure(let error):
                    completion(.failure(.generic(error)))
            }
        }
    }
}

import Foundation

protocol APIClientProtocol {
    func requestGet(url: URL, completion: @escaping (Result<Data, ServiceError>) -> Void)
}

struct APIClient: APIClientProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func requestGet(url: URL, completion: @escaping (Result<Data, ServiceError>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            guard let jsonData = data else {
                return completion(.failure(.invalidData))
            }
            completion(.success(jsonData))
        }.resume()
    }
}

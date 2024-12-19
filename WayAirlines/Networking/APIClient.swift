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
        print("➡️ [REQUEST] GET: \(url.absoluteString)")
        session.dataTask(with: url) { (data, response, error) in
            guard let jsonData = data else {
                return completion(.failure(.invalidData))
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("[RESPONSE] Status code: \(httpResponse.statusCode)")
            }
            if let jsonString = jsonData.prettyPrintedJSONString() {
                print("[RESPONSE DATA] JSON Response:\n\(jsonString)")
            } else {
                print("[WARNING] Could not format JSON response")
            }
            completion(.success(jsonData))
        }.resume()
    }
}

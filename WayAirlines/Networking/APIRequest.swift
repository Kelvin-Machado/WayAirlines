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
        let useMockData = true
        
        if useMockData {
            fetchMockFlightsData(completion: completion)
            return
        }
        
        fetchFlightsFromAPI(completion: completion)
    }

    private func fetchMockFlightsData(completion: @escaping (Result<Flights, ServiceError>) -> Void) {
        print("Carregando histórico de voos mockados...")
        let jsonString = getMockFlightsData()
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            completion(.failure(.generic(NSError(domain: "MockDataError", code: 0, userInfo: nil))))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(Flights.self, from: jsonData)
            completion(.success(decoded))
        } catch let error {
            completion(.failure(.generic(error)))
        }
    }

    private func fetchFlightsFromAPI(completion: @escaping (Result<Flights, ServiceError>) -> Void) {
        guard let api = URL(string: apiURL) else {
            completion(.failure(.invalidUrl))
            return
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
func getMockFlightsData() -> String {
    return """
    {
      "flights" : [
        {
          "status" : "CONCLUIDO",
          "start_date" : "2024-08-01",
          "arrival_time" : "14:00",
          "departure_time" : "10:00",
          "arrival_airport" : "LAX - Los Angeles International Airport",
          "completion_status" : "ATRASOU",
          "flight_id" : "AB123",
          "end_date" : "2024-08-01",
          "departure_airport" : "JFK - John F. Kennedy International Airport",
          "airplane_name" : "Boeing 737"
        },
        {
          "status" : "CONCLUIDO",
          "start_date" : "2024-08-03",
          "arrival_time" : "19:45",
          "departure_time" : "15:30",
          "arrival_airport" : "MIA - Miami International Airport",
          "completion_status" : "NO_HORARIO",
          "flight_id" : "CD456",
          "end_date" : "2024-08-03",
          "departure_airport" : "ORD - O'Hare International Airport",
          "airplane_name" : "Airbus A320"
        },
        {
          "status" : "CANCELADO",
          "start_date" : "2024-08-05",
          "arrival_time" : "11:30",
          "departure_time" : "08:00",
          "arrival_airport" : "SEA - Seattle-Tacoma International Airport",
          "completion_status" : "CANCELADO",
          "flight_id" : "EF789",
          "end_date" : "2024-08-05",
          "departure_airport" : "SFO - San Francisco International Airport",
          "airplane_name" : "Boeing 747"
        },
        {
          "status" : "CONCLUIDO",
          "start_date" : "2024-08-07",
          "arrival_time" : "13:30",
          "departure_time" : "09:45",
          "arrival_airport" : "DFW - Dallas/Fort Worth International Airport",
          "completion_status" : "ATRASOU",
          "flight_id" : "GH012",
          "end_date" : "2024-08-07",
          "departure_airport" : "ATL - Hartsfield-Jackson Atlanta International Airport",
          "airplane_name" : "Boeing 777"
        },
        {
          "status" : "CONCLUIDO",
          "start_date" : "2024-08-09",
          "arrival_time" : "16:15",
          "departure_time" : "12:00",
          "arrival_airport" : "LAX - Los Angeles International Airport",
          "completion_status" : "NO_HORARIO",
          "flight_id" : "IJ345",
          "end_date" : "2024-08-09",
          "departure_airport" : "BOS - Logan International Airport",
          "airplane_name" : "Airbus A380"
        },
        {
          "status" : "CANCELADO",
          "start_date" : "2024-08-11",
          "arrival_time" : "14:50",
          "departure_time" : "11:30",
          "arrival_airport" : "JFK - John F. Kennedy International Airport",
          "completion_status" : "CANCELADO",
          "flight_id" : "KL678",
          "end_date" : "2024-08-11",
          "departure_airport" : "MIA - Miami International Airport",
          "airplane_name" : "Boeing 737"
        },
        {
          "status" : "CONCLUIDO",
          "start_date" : "2024-08-13",
          "arrival_time" : "09:30",
          "departure_time" : "06:00",
          "arrival_airport" : "SFO - San Francisco International Airport",
          "completion_status" : "ATRASOU",
          "flight_id" : "MN901",
          "end_date" : "2024-08-13",
          "departure_airport" : "LAX - Los Angeles International Airport",
          "airplane_name" : "Airbus A320"
        },
        {
          "status" : "CONCLUIDO",
          "start_date" : "2024-08-15",
          "arrival_time" : "18:30",
          "departure_time" : "14:00",
          "arrival_airport" : "ORD - O'Hare International Airport",
          "completion_status" : "NO_HORARIO",
          "flight_id" : "OP234",
          "end_date" : "2024-08-15",
          "departure_airport" : "SEA - Seattle-Tacoma International Airport",
          "airplane_name" : "Boeing 777"
        },
        {
          "status" : "CANCELADO",
          "start_date" : "2024-08-17",
          "arrival_time" : "13:45",
          "departure_time" : "10:30",
          "arrival_airport" : "ATL - Hartsfield-Jackson Atlanta International Airport",
          "completion_status" : "CANCELADO",
          "flight_id" : "QR567",
          "end_date" : "2024-08-17",
          "departure_airport" : "DFW - Dallas/Fort Worth International Airport",
          "airplane_name" : "Boeing 747"
        },
        {
          "status" : "CONCLUIDO",
          "start_date" : "2024-08-19",
          "arrival_time" : "20:45",
          "departure_time" : "17:00",
          "arrival_airport" : "MIA - Miami International Airport",
          "completion_status" : "ATRASOU",
          "flight_id" : "ST890",
          "end_date" : "2024-08-19",
          "departure_airport" : "LGA - LaGuardia Airport",
          "airplane_name" : "Airbus A380"
        },
        {
          "status" : "CONCLUIDO",
          "start_date" : "2024-08-21",
          "arrival_time" : "12:15",
          "departure_time" : "08:30",
          "arrival_airport" : "DFW - Dallas/Fort Worth International Airport",
          "completion_status" : "NO_HORARIO",
          "flight_id" : "UV123",
          "end_date" : "2024-08-21",
          "departure_airport" : "ORD - O'Hare International Airport",
          "airplane_name" : "Boeing 737"
        },
        {
          "status" : "CANCELADO",
          "start_date" : "2024-08-23",
          "arrival_time" : "19:30",
          "departure_time" : "16:00",
          "arrival_airport" : "JFK - John F. Kennedy International Airport",
          "completion_status" : "CANCELADO",
          "flight_id" : "WX456",
          "end_date" : "2024-08-23",
          "departure_airport" : "SFO - San Francisco International Airport",
          "airplane_name" : "Airbus A320"
        },
        {
          "status" : "CONCLUIDO",
          "start_date" : "2024-08-25",
          "arrival_time" : "14:45",
          "departure_time" : "11:00",
          "arrival_airport" : "LAX - Los Angeles International Airport",
          "completion_status" : "ATRASOU",
          "flight_id" : "YZ789",
          "end_date" : "2024-08-25",
          "departure_airport" : "ATL - Hartsfield-Jackson Atlanta International Airport",
          "airplane_name" : "Boeing 777"
        },
        {
          "status" : "CONCLUIDO",
          "start_date" : "2024-08-27",
          "arrival_time" : "12:30",
          "departure_time" : "09:00",
          "arrival_airport" : "ORD - O'Hare International Airport",
          "completion_status" : "NO_HORARIO",
          "flight_id" : "AB987",
          "end_date" : "2024-08-27",
          "departure_airport" : "SEA - Seattle-Tacoma International Airport",
          "airplane_name" : "Boeing 747"
        },
        {
          "status" : "CANCELADO",
          "start_date" : "2024-08-29",
          "arrival_time" : "16:45",
          "departure_time" : "13:00",
          "arrival_airport" : "MIA - Miami International Airport",
          "completion_status" : "CANCELADO",
          "flight_id" : "CD654",
          "end_date" : "2024-08-29",
          "departure_airport" : "JFK - John F. Kennedy International Airport",
          "airplane_name" : "Airbus A320"
        },
        {
          "status" : "CONCLUIDO",
          "start_date" : "2024-08-31",
          "arrival_time" : "10:45",
          "departure_time" : "07:30",
          "arrival_airport" : "DFW - Dallas/Fort Worth International Airport",
          "completion_status" : "ATRASOU",
          "flight_id" : "EF321",
          "end_date" : "2024-08-31",
          "departure_airport" : "LAX - Los Angeles International Airport",
          "airplane_name" : "Boeing 737"
        },
        {
          "status" : "CONCLUIDO",
          "start_date" : "2024-09-02",
          "arrival_time" : "15:45",
          "departure_time" : "12:15",
          "arrival_airport" : "SEA - Seattle-Tacoma International Airport",
          "completion_status" : "NO_HORARIO",
          "flight_id" : "GH098",
          "end_date" : "2024-09-02",
          "departure_airport" : "ORD - O'Hare International Airport",
          "airplane_name" : "Airbus A380"
        },
        {
          "status" : "CANCELADO",
          "start_date" : "2024-09-04",
          "arrival_time" : "21:45",
          "departure_time" : "18:00",
          "arrival_airport" : "LAX - Los Angeles International Airport",
          "completion_status" : "CANCELADO",
          "flight_id" : "IJ765",
          "end_date" : "2024-09-04",
          "departure_airport" : "MIA - Miami International Airport",
          "airplane_name" : "Boeing 747"
        },
        {
          "status" : "CONCLUIDO",
          "start_date" : "2024-09-06",
          "arrival_time" : "17:15",
          "departure_time" : "13:30",
          "arrival_airport" : "ORD - O'Hare International Airport",
          "completion_status" : "ATRASOU",
          "flight_id" : "KL432",
          "end_date" : "2024-09-06",
          "departure_airport" : "JFK - John F. Kennedy International Airport",
          "airplane_name" : "Boeing 737"
        },
        {
          "status" : "CONCLUIDO",
          "start_date" : "2024-09-08",
          "arrival_time" : "09:00",
          "departure_time" : "05:45",
          "arrival_airport" : "ATL - Hartsfield-Jackson Atlanta International Airport",
          "completion_status" : "NO_HORARIO",
          "flight_id" : "MN109",
          "end_date" : "2024-09-08",
          "departure_airport" : "LAX - Los Angeles International Airport",
          "airplane_name" : "Airbus A320"
        }
      ]
    }
    """
}

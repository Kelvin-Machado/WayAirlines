
struct Flights: Codable {
    let flights: [Flight]
}

struct Flight: Codable {
    let flightID: String
    let status: Status
    let completionStatus: CompletionStatus
    let startDate, endDate, departureTime, arrivalTime: String
    let departureAirport, arrivalAirport, airplaneName: String

    enum CodingKeys: String, CodingKey {
        case flightID = "flight_id"
        case status
        case completionStatus = "completion_status"
        case startDate = "start_date"
        case endDate = "end_date"
        case departureTime = "departure_time"
        case arrivalTime = "arrival_time"
        case departureAirport = "departure_airport"
        case arrivalAirport = "arrival_airport"
        case airplaneName = "airplane_name"
    }
}

enum CompletionStatus: String, Codable {
    case atrasou = "ATRASOU"
    case cancelado = "CANCELADO"
    case noHorario = "NO_HORARIO"
}

enum Status: String, Codable {
    case cancelado = "CANCELADO"
    case concluido = "CONCLUIDO"
    case emAndamento = "EM_ANDAMENTO"
}

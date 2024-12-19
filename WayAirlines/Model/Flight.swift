
struct Flights: Codable, Equatable {
    let flights: [Flight]
}

struct Flight: Codable, Equatable {
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
    
    func getImageName() -> String {
        switch self {
        case .atrasou:
            return FlightStatus.delayedFlight.imageName
        case .cancelado:
            return FlightStatus.cancelledFlight.imageName
        case .noHorario:
            return FlightStatus.onTimeFlight.imageName
        }
    }
    
    func formatStatusText() -> String {
        switch self {
        case .atrasou:
            return "Atrasou"
        case .cancelado:
            return "Cancelado"
        case .noHorario:
            return "No horário"
        }
    }
}

enum Status: String, Codable {
    case cancelado = "CANCELADO"
    case concluido = "CONCLUIDO"
    case emAndamento = "EM_ANDAMENTO"
    
    func getImageName() -> String {
        switch self {
        case .concluido:
            return FlightStatus.completedFlight.imageName
        case .cancelado:
            return FlightStatus.cancelledFlight.imageName
        case .emAndamento:
            return FlightStatus.ongoingFlight.imageName
        }
    }
    
    func formatStatusText() -> String {
        switch self {
        case .concluido:
            return "Concluído"
        case .cancelado:
            return "Cancelado"
        case .emAndamento:
            return "Em andamento"
        }
    }
}

enum FlightStatus: CaseIterable {
    case allFlights
    case completedFlight
    case cancelledFlight
    case delayedFlight
    case onTimeFlight
    case ongoingFlight
    
    var imageName: String {
        switch self {
        case .allFlights:
            return "all_flights"
        case .completedFlight:
            return "completed_flight"
        case .cancelledFlight:
            return "cancelled_flight"
        case .delayedFlight:
            return "delayed_flight"
        case .onTimeFlight:
            return "on_time_flight"
        case .ongoingFlight:
            return "ongoing_flights"
        }
    }
    
    var text: String {
        switch self {
        case .allFlights:
            return "Todos os Voos"
        case .completedFlight:
            return "Voos Concluídos"
        case .cancelledFlight:
            return "Voos Cancelados"
        case .delayedFlight:
            return "Voos Atrasados"
        case .onTimeFlight:
            return "Voos no Horário"
        case .ongoingFlight:
            return "Voos em Andamento"
        }
    }
}

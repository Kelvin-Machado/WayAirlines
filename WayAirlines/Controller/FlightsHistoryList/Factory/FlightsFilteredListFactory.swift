struct FlightsFilteredListFactory {
    static func makeFilteredFlights(for status: FlightStatus, with flightsHistory: [Flight]) -> (flights: [Flight], title: String) {
        let filteredFlights: [Flight]
        let title: String
        
        switch status {
        case .allFlights:
            filteredFlights = flightsHistory
            title = "Todos os Voos"
        case .completedFlight:
            filteredFlights = flightsHistory.filter { $0.status == .concluido }
            title = "Voos concluídos"
        case .cancelledFlight:
            filteredFlights = flightsHistory.filter { $0.status == .cancelado }
            title = "Voos cancelados"
        case .delayedFlight:
            filteredFlights = flightsHistory.filter { $0.completionStatus == .atrasou }
            title = "Voos atrasados"
        case .onTimeFlight:
            filteredFlights = flightsHistory.filter { $0.completionStatus == .noHorario }
            title = "Voos no horário"
        case .ongoingFlight:
            filteredFlights = flightsHistory.filter { $0.status == .emAndamento }
            title = "Voos em andamento"
        }
        
        return (flights: filteredFlights, title: title)
    }
}


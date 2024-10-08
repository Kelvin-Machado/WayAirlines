import XCTest
@testable import TesteVaDeTaxi

final class FlightsHistoryViewModelTests: XCTestCase {
    private lazy var serviceSpy = FlightsHistoryServiceSpy()
    private lazy var viewControllerSpy = FlightsHistoryViewControllerSpy()
    private lazy var sut: FlightsHistoryViewModel = {
        let sut = FlightsHistoryViewModel(service: serviceSpy)
        sut.output = viewControllerSpy
        return sut
    }()
    
    func test_flightsHistorySuccess() {
        let expectedContact = Flights(flights: [
            Flight(flightID: "", status: .concluido, completionStatus: .noHorario, startDate: "", endDate: "", departureTime: "", arrivalTime: "", departureAirport: "", arrivalAirport: "", airplaneName: "")
        ])
        serviceSpy.recievedResult = .success(expectedContact)
        
        sut.loadFlights()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.serviceSpy.fetchFlightsCount, 1)
            XCTAssertEqual(self.viewControllerSpy.calledMethods, [.showFlights(expectedContact)])
        }
    }
    
    func test_flightsHistoryFailure() {
        serviceSpy.recievedResult = .failure(.invalidData)
        
        sut.loadFlights()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewControllerSpy.calledMethods, [.showError(ServiceError.invalidData.localizedDescription)])
            XCTAssertEqual(self.serviceSpy.fetchFlightsCount, 1)
        }
    }
}

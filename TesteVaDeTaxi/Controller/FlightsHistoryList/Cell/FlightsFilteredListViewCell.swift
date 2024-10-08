import UIKit

final class FlightsFilteredListViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: FlightsFilteredListViewCell.self)
    
    private let topIconImageView = createIconImageView()
    private let bottomIconImageView = createIconImageView()
    
    private let airplaneNameLabel = createLabel(fontSize: 18)
    private let flightIDLabel = createLabel(fontSize: 18)
    private let statusLabel = createLabel(fontSize: 16)
    private let completeStatusLabel = createLabel(fontSize: 16)
    private let startDateLabel = createLabel(fontSize: 16)
    private let endDateLabel = createLabel(fontSize: 16)
    private let departureAirportLabel = createLabel(fontSize: 16)
    private let arrivalAirportLabel = createLabel(fontSize: 16)


    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        topIconImageView.image = nil
        bottomIconImageView.image = nil
        airplaneNameLabel.text = nil
        flightIDLabel.text = nil
        statusLabel.text = nil
        completeStatusLabel.text = nil
        startDateLabel.text = nil
        endDateLabel.text = nil
        departureAirportLabel.text = nil
        arrivalAirportLabel.text = nil
    }

    func configure(flightData: Flight) {
        if flightData.status == .cancelado && flightData.completionStatus == .cancelado {
            topIconImageView.image = UIImage(named: flightData.status.getImageName())
            bottomIconImageView.isHidden = true
        } else {
            topIconImageView.image = UIImage(named: flightData.status.getImageName())
            bottomIconImageView.image = UIImage(named: flightData.completionStatus.getImageName())
            bottomIconImageView.isHidden = false
        }

        airplaneNameLabel.text = flightData.airplaneName
        flightIDLabel.text = "ID: \(flightData.flightID)"
        statusLabel.text = "Status: \(flightData.status.formatStatusText())"
        completeStatusLabel.text = "Status de conclusão: \(flightData.completionStatus.formatStatusText())"
        startDateLabel.text = "Partida: \(flightData.startDate)"
        endDateLabel.text = "Chegada: \(flightData.endDate)"
        departureAirportLabel.numberOfLines = 0
        departureAirportLabel.text = "Aeroporto de partida:\n\(flightData.departureAirport)"
        arrivalAirportLabel.numberOfLines = 0
        arrivalAirportLabel.text = "Aeroporto de chegada:\n\(flightData.arrivalAirport)"
    }

    private func prepareView() {
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.backgroundColor = .white
        
        let titleStackView = UIStackView(arrangedSubviews: [
            airplaneNameLabel, flightIDLabel
        ])
        titleStackView.axis = .horizontal
        titleStackView.spacing = 4
        
        let labelsStackView = UIStackView(arrangedSubviews: [
            statusLabel, completeStatusLabel,
            startDateLabel, endDateLabel, departureAirportLabel, arrivalAirportLabel
        ])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 4
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(topIconImageView)
        contentView.addSubview(bottomIconImageView)
        contentView.addSubview(titleStackView)
        contentView.addSubview(labelsStackView)
        
        topIconImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomIconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            topIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            topIconImageView.widthAnchor.constraint(equalToConstant: 40),
            topIconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            bottomIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bottomIconImageView.topAnchor.constraint(equalTo: topIconImageView.bottomAnchor, constant: 8),
            bottomIconImageView.widthAnchor.constraint(equalToConstant: 40),
            bottomIconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            titleStackView.leadingAnchor.constraint(equalTo: topIconImageView.trailingAnchor, constant: 16),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            labelsStackView.leadingAnchor.constraint(equalTo: topIconImageView.trailingAnchor, constant: 16),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelsStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 8)
        ])
    }

    private static func createIconImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    private static func createLabel(fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        label.textColor = .black
        return label
    }
}

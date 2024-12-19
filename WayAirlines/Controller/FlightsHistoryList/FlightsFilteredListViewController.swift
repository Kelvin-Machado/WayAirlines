import UIKit

final class FlightsFilteredListViewController: BaseViewController {
    
    private var collectionView: UICollectionView!
    private var flightsHistory: [Flight]
    
    init(flightsHistory: [Flight]) {
        self.flightsHistory = flightsHistory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 40, height: 280)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(cellType: FlightsFilteredListViewCell.self)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        
        view.addSubview(collectionView)
    }
}

extension FlightsFilteredListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flightsHistory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FlightsFilteredListViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        let flightData = flightsHistory[indexPath.row]
        cell.configure(flightData: flightData)
        
        return cell
    }
}

//
//  FlightsHistoryViewController.swift
//  TesteVaDeTaxi
//
//  Created by Kelvin Batista Machado on 06/10/24.
//

import UIKit

final class FlightsHistoryViewController: BaseViewController {
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: view.frame.width - 40, height: 80)
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = .clear
            collectionView.register(cellType: FlightsHistoryViewCell.self)
            
            view.addSubview(collectionView)
        }
}

extension FlightsHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FlightsHistoryViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(image: UIImage(named: "all_flights"), text: "Todos os Voos")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped item")
    }
}


import UIKit

final class HomeViewController: BaseViewController {
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarImage()
        setupCollectionView()
    }
    
    private func setupNavigationBarImage() {
        let logoImage = UIImage(named: "logo_mini")
        let imageView = UIImageView(image: logoImage)
        imageView.contentMode = .scaleAspectFit
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        containerView.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        navigationItem.titleView = containerView
    }
    
    private func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: view.frame.width - 40, height: 120)
            layout.sectionInset = UIEdgeInsets(top: 80, left: 20, bottom: 20, right: 20)
            
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = .clear
            collectionView.register(cellType: HomeCollectionViewCell.self)
            
            view.addSubview(collectionView)
        }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(image: UIImage(named: "plane"), text: "Histórico de Voos")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped item")
    }
}

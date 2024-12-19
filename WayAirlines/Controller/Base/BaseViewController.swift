import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
    }
    
    func setupBaseUI() {
        setupGradientBackground()
        initNavigationController()
    }

    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds

        gradientLayer.colors = [
            UIColor(hexString: "0E7AFE")?.cgColor ?? UIColor.blue,
            UIColor.white.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func initNavigationController() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        let titleTextAttr: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .shadow: NSShadow()
        ]
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor.white
        navigationBarAppearance.shadowColor = UIColor.clear
        navigationBarAppearance.titleTextAttributes = titleTextAttr
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationBar.compactAppearance = navigationBarAppearance
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.topItem?.backButtonTitle = ""
        navigationBar.barTintColor = .black
        navigationBar.tintColor = UIColor(hexString: "0E7AFE")
        navigationBar.isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = titleTextAttr
        navigationBar.titleTextAttributes = titleTextAttr
    }
}

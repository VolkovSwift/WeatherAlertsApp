import UIKit

protocol ErrorPresentable {
    func showAlert(with error: NetworkingError)
}

extension ErrorPresentable where Self: UIViewController {
    func showAlert(with error: NetworkingError) {
        let alertVC = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true)
    }
}

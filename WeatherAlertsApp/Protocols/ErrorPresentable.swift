import UIKit

protocol ErrorPresentable {
    func showAlert(with error: NetworkingError)
}

extension ErrorPresentable where Self: UIViewController {
    func showAlert(with error: NetworkingError) {
        let alertVC = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alertVC.addAction(alertAction)
        alertVC.addAction(cancelAction)
       
        self.present(alertVC, animated: true)
    }
}

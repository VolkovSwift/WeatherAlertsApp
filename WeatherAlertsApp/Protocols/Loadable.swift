import UIKit

protocol Loadable {
    func showLoader()
    func hideLoader()
}

extension Loadable where Self: UIViewController {
    func showLoader() {
        if let activityIndicator = findActivity() {
            activityIndicator.startAnimating()
        } else {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
            
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
            ])
        }
    }
    
    func hideLoader() {
        findActivity()?.stopAnimating()
    }
    
    private func findActivity() -> UIActivityIndicatorView? {
        return view.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
    }
}

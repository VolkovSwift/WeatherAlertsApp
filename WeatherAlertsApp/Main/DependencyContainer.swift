import UIKit

protocol ViewControllerFactory {
    func makeMainViewController() -> MainViewController
}

class DependencyContainer {
    private lazy var networkingManager = NetworkingManager()
}

extension DependencyContainer: ViewControllerFactory {
    func makeMainViewController() -> MainViewController {
        let presenter = MainPresenter(networkingManager: networkingManager)
        let viewController = MainViewController(presenter: presenter)
        presenter.viewDelegate = viewController
        return viewController
    }
}

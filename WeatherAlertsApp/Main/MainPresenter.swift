protocol MainPresenterProtocol {
    func getWeatherAlerts()
}

final class MainPresenter: MainPresenterProtocol {
    
    // MARK: - Internal properties
    
    weak var viewDelegate: MainViewDelegate?
    
    // MARK: - Private properties
    
    private let networkingManager: NetworkingManagerProtocol
    
    // MARK: - Initialization
    
    init(networkingManager: NetworkingManagerProtocol) {
        self.networkingManager = networkingManager
    }
    
    // MARK: - Internal methods
    
    func getWeatherAlerts() {
        networkingManager.request(endpoint: WeatherAPI.alerts) { [weak self] (result: Result<DataResponse, NetworkingError>) in
            switch result {
            case .success(let model):
                let models = model.features.map { $0.properties }
                print(models)
                self?.viewDelegate?.loadingProcessed(result: .success(models))
            case .failure(let error):
                self?.viewDelegate?.loadingProcessed(result: .failure(error))
            }
        }
    }
}

import UIKit

protocol MainViewDelegate: AnyObject {
    func loadingProcessed(result: Result<[WeatherAlertModel], NetworkingError>)
}

final class MainViewController: UIViewController, Loadable, ErrorPresentable {
    
    // MARK: - Private properties
    
    private var items: [WeatherAlertModel] = []
    private let presenter: MainPresenterProtocol
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WeatherDetailsCell.self, forCellReuseIdentifier: WeatherDetailsCell.reuseID)
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoader()
        tableView.pinToSuperView()
        presenter.getWeatherAlerts()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailsCell.reuseID,
                                                       for: indexPath) as? WeatherDetailsCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate {
    func loadingProcessed(result: Result<[WeatherAlertModel], NetworkingError>) {
        DispatchQueue.main.async {
            self.hideLoader()
            switch result {
            case .success(let items):
                self.items = items
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(with: error)
            }
        }
    }
}

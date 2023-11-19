import UIKit

final class WeatherDetailsCell: UITableViewCell {
    
    static var reuseID: String {
        String(describing: self)
    }
    
    private struct Size {
        static let mainStackViewPadding: CGFloat = 12
        static let mainStackViewSpacing: CGFloat = 14
        static let logoImageWidth: CGFloat = 80
    }
    
    // MARK: - Private properties
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = Size.mainStackViewSpacing
        return stackView
    }()
    
    private let verticalInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: Size.logoImageWidth).isActive = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private let endDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()

    private let sourceNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()

    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        logoImage.image = nil
        titleLabel.text = nil
        startDateLabel.text = nil
        endDateLabel.text = nil
        sourceNameLabel.text = nil
        durationLabel.text = nil
    }
    
    // MARK: - Internal methods
    
    func configure(with model: WeatherAlertModel) {
        configureLogoImage(with: model)
        configureLabels(with: model)
        configureStartDateLabel(with: model)
        configureEndDateLabel(with: model)
    }
    
    // MARK: - Private methods
    
    private func configureLogoImage(with model: WeatherAlertModel) {
        let url = URL(string: "\(Constants.imageURL)?\(model.id)")
        logoImage.setImage(withURL: url)
    }
    
    private func configureStartDateLabel(with model: WeatherAlertModel) {
        guard let startDate = model.startDate?.convertDateMonthDayYear() else { return }
        startDateLabel.text = "START DATE: \(startDate)"
    }
    
    private func configureEndDateLabel(with model: WeatherAlertModel) {
        guard let endDate = model.endDate?.convertDateMonthDayYear() else { return }
        endDateLabel.text = "END DATE: \(endDate)"
    }
    
    private func configureLabels(with model: WeatherAlertModel) {
        titleLabel.text = model.event
        sourceNameLabel.text = "SOURCE: \(model.senderName)"
        guard let startDate = model.startDate,
              let endDate = model.endDate,
              let duration = startDate.getDuration(to: endDate) else { return }
        durationLabel.text = duration
    }
    
    private func setupLayout() {
        setupVerticalInfoStackViewLayout()
        setupMainStackViewLayout()
    }
    
    private func setupVerticalInfoStackViewLayout() {
        [titleLabel, startDateLabel, endDateLabel, durationLabel, sourceNameLabel].forEach { verticalInfoStackView.addArrangedSubview($0)
        }
    }
    
    private func setupMainStackViewLayout() {
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(logoImage)
        mainStackView.addArrangedSubview(verticalInfoStackView)
        mainStackView.pinToSuperView(with: Size.mainStackViewPadding)
    }
}

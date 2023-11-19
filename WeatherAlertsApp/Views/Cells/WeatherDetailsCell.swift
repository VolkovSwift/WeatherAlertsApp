import UIKit

final class WeatherDetailsCell: UITableViewCell {
    
    static var reuseID: String {
        String(describing: self)
    }
    
    private struct Size {
        static let mainStackViewPadding: CGFloat = 12
        static let mainStackViewSpacing: CGFloat = 14
        static let logoImageHeight: CGFloat = 80
        static let logoImageWidth: CGFloat = 80
    }
    
    // MARK: - Private properties
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.contentMode = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = Size.mainStackViewSpacing
        return stackView
    }()
    
    private let verticalInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: Size.logoImageWidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Size.logoImageHeight).isActive = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
//        label.font = .interstateRegular(of: 15.0)
//        label.textColor = .hex_4A4A4A_100
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
        sourceNameLabel.text = nil
        durationLabel.text = nil
    }
    
    // MARK: - Internal methods
    
    func configure(with model: WeatherAlertModel) {
        guard let startDate = model.startDate?.convertDateMonthDayYear(),
        let endDate = model.endDate?.convertDateMonthDayYear() else { return }
        
        logoImage.loadImage(fromURL: URL(string: "https://picsum.photos/1000")!, identifier: model.id)
        
//        logoImage.setImage(withURL: URL(string: "https://picsum.photos/1000"))
        titleLabel.text = model.event
        startDateLabel.text = "START DATE: \(startDate)"
        endDateLabel.text = "END DATE: \(endDate)"
        sourceNameLabel.text = "SOURCE: \(model.senderName)"
        durationLabel.text = model.calculateDuration() ?? ""
    }

    // MARK: - Private methods
    
    private func setupLayout() {
        selectionStyle = .none
        clipsToBounds = true
        setupVerticalInfoStackViewLayout()
        setupMainStackViewLayout()
    }
    
    private func setupVerticalInfoStackViewLayout() {
        verticalInfoStackView.addArrangedSubview(titleLabel)
        verticalInfoStackView.addArrangedSubview(startDateLabel)
        verticalInfoStackView.addArrangedSubview(endDateLabel)
        
        verticalInfoStackView.addArrangedSubview(sourceNameLabel)
        verticalInfoStackView.addArrangedSubview(durationLabel)

//        verticalInfoStackView.setCustomSpacing(6, after: titleLabel)
//        verticalInfoStackView.setCustomSpacing(6, after: expirationDateLabel)
    }
    
    private func setupMainStackViewLayout() {
        mainStackView.addArrangedSubview(logoImage)
        mainStackView.addArrangedSubview(verticalInfoStackView)
        contentView.addSubview(mainStackView)
        mainStackView.pinToSuperView(with: Size.mainStackViewPadding)
    }
}

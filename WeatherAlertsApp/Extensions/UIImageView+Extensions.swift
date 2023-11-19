import UIKit
import Kingfisher

extension UIImageView {
    func setImage(withURL url: URL?, placeholder: UIImage? = UIImage(named: "placeholderImage")) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: placeholder)
    }
}

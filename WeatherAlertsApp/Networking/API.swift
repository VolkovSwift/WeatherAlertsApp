
import Foundation

protocol API {
    var scheme: HTTPScheme { get }
    var method: HTTPMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var apiParameters: [URLQueryItem] { get }
}

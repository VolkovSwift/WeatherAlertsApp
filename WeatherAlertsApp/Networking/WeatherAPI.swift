import Foundation

enum WeatherAPI: API {
    
    case alerts
    
    var scheme: HTTPScheme {
        switch self {
        case .alerts:
            return .https
        }
    }
    var method: HTTPMethod {
        switch self {
        case .alerts:
            return .get
        }
    }
    var baseURL: String {
        switch self {
        case .alerts:
            return "api.weather.gov"
        }
    }
        
    var path: String {
        switch self {
        case .alerts:
            return "/alerts/active"
        }
    }
        
    var apiParameters: [URLQueryItem] {
        switch self {
        case .alerts:
            return [
                URLQueryItem(name: "status", value: "actual"),
                URLQueryItem(name: "message_type", value: "alert")]
        }
    }
}

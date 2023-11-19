import Foundation

struct DataResponse: Codable {
    let features: [Feature]
}

struct Feature: Codable {
    let properties: WeatherAlertModel
}

struct WeatherAlertModel: Codable {
    let id: String
    let event: String
    let senderName: String
    let effective: String?
    let ends: String?
    
    var startDate: Date? {
        guard let effective else { return nil }
        return DateFormatter.eventTimeFormatter.date(from: effective)
    }
    
    var endDate: Date? {
        guard let ends else { return nil }
        return DateFormatter.eventTimeFormatter.date(from: ends)
    }
}

import Foundation

extension DateFormatter {
    static var eventTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "en")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
    
    static var monthDayYear: DateFormatter {
        return DateFormatter.formatter(by: "MM/dd/yyyy HH:mm")
    }
    
    class func formatter(by format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}

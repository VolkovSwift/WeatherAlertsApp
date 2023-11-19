import Foundation

extension String {
    var eventDate: Date? {
        return DateFormatter.eventTimeFormatter.date(from: self)
    }
}

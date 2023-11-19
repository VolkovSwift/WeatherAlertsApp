import Foundation

extension Date {
    func convertDateMonthDayYear() -> String {
        return DateFormatter.monthDayYear.string(from: self)
    }
    
    func getDuration(to endDate: Date) -> String? {
        let components = Calendar.current.dateComponents([.day, .hour, .minute],
                                                         from: self,
                                                         to: endDate)
        
        guard let days = components.day,
              let hours = components.hour,
              let minutes = components.minute else { return nil }
        
        return "DURATION: \(days)d \(hours)h \(minutes)m"
    }
    
}

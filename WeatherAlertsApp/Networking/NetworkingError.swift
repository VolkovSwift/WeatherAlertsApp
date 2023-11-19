import Foundation

enum NetworkingError: String, Error {
    case invalidURL = "The URL address is invalid."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidData = "The data received from the server was invalid."
    case invalidResponse = "Invalid response from the server."
}

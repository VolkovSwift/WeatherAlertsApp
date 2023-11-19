import Foundation

protocol NetworkingManagerProtocol {
    func request<T: Codable>(endpoint: API, completion: @escaping (Result<T, NetworkingError>) -> Void)
}

final class NetworkingManager: NetworkingManagerProtocol {
    private func buildURL(endpoint: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.apiParameters
        return components
    }
    
    func request<T: Codable>(endpoint: API, completion: @escaping (Result<T, NetworkingError>) -> Void) {
        let components = buildURL(endpoint: endpoint)
        
        guard let url = components.url else {
            completion(.failure(.unableToComplete))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            if error != nil {
                completion(.failure(.invalidURL))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        dataTask.resume()
    }
}

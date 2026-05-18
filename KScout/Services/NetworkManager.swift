import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    // API-Football 발급 키
    private let apiKey = "YOUR_API_KEY_HERE"
    
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "x-apisports-key")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw NetworkError.decodingError
        }
    }
}

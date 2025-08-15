//
//  NetworkService.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import Foundation
import Network

// MARK: - Network Error Types
public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case invalidResponse
    case networkUnavailable
    case timeout
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided"
        case .noData:
            return "No data received from server"
        case .decodingError:
            return "Failed to decode server response"
        case .invalidResponse:
            return "Invalid response from server"
        case .networkUnavailable:
            return "Network connection unavailable"
        case .timeout:
            return "Request timed out"
        }
    }
}

// MARK: - Network Service Protocol
public protocol NetworkServiceProtocol {
    func fetch<T: Codable>(url: URL) async throws -> T
    func checkConnection() -> Bool
}

// MARK: - Network Service Implementation
public class NetworkService: NetworkServiceProtocol {
    public static let shared = NetworkService()
    
    private let session: URLSession
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published private(set) var isConnected = true
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10.0
        config.timeoutIntervalForResource = 30.0
        config.waitsForConnectivity = true
        
        self.session = URLSession(configuration: config)
        self.monitor = NWPathMonitor()
        
        setupNetworkMonitoring()
    }
    
    private func setupNetworkMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    public func fetch<T: Codable>(url: URL) async throws -> T {
        // Check network connectivity
        guard isConnected else {
            throw NetworkError.networkUnavailable
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            // Validate HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                throw NetworkError.invalidResponse
            }
            
            // Validate data
            guard !data.isEmpty else {
                throw NetworkError.noData
            }
            
            // Decode JSON
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            } catch {
                print("Decoding error: \(error)")
                throw NetworkError.decodingError
            }
            
        } catch {
            if error is NetworkError {
                throw error
            } else {
                print("Network request error: \(error)")
                throw NetworkError.networkUnavailable
            }
        }
    }
    
    public func checkConnection() -> Bool {
        return isConnected
    }
}

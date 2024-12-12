//
//  NetworkService.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//



import Foundation

final class NetworkService {
	
	// MARK: - Singleton
	static let shared = NetworkService()
	private init() { }

	// MARK: - URLSession
	private let session: URLSession = {
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = 30
		configuration.timeoutIntervalForResource = 60
		return URLSession(configuration: configuration)
	}()
	
		
	func fetchToken() async throws -> String {
		
		guard let url = makeURL(for: .fetchToken) else { throw URLError(.badURL) }
		
		let (data, response) = try await session.data(from: url)
		
		guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.cannotParseResponse) }
		
		switch httpResponse.statusCode {
		case 200...299:
			let decoder = JSONDecoder()
			let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
			return tokenResponse.token
		default:
			throw URLError(.badServerResponse)
		}
		
		
	}
	
	
	private func makeURL(for request: RequestType) -> URL? {
		
		var components = URLComponents()
		components.scheme = "https"
		components.host = "frontend-test-assignment-api.abz.agency"
		let basePath = "/api/v1"
		
		switch request {
		case .fetchUsers(let page, let count):
			components.path = basePath + "/users"
			
			components.queryItems = [
				URLQueryItem(name: "page", value: "\(page)"),
				URLQueryItem(name: "count", value: "\(count)")
			]
		case .fetchToken:
			components.path = basePath + "/token"
		case .registerUser:
			components.path = basePath + "/users"
		}
		return components.url
	}
	
	
	
}

// MARK: - HTTP Method Enum
enum RequestType {
	case fetchUsers(page: Int, count: Int = 6)
	case fetchToken
	case registerUser
}


struct TokenResponse: Decodable {
	let success: Bool
	let token: String
}

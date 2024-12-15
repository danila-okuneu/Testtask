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
		
		guard let url = makeURL(to: .fetchToken) else { throw URLError(.badURL) }
		
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
	
	func fetchUsers(page: Int, count: Int = 6) async throws -> UsersResponse {
		
		guard let url = makeURL(to: .fetchUsers(page: page, count: count)) else { throw URLError(.badURL) }

		let (data, response) = try await session.data(from: url)
		
		guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.cannotParseResponse) }
		
		switch httpResponse.statusCode {
		case 200...299:
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			
			let users = try decoder.decode(UsersResponse.self, from: data)
			return users
		default:
			throw URLError(.badServerResponse)
		}
	}
	
	func fetchUsers(from url: URL) async throws -> UsersResponse {
		let (data, response) = try await session.data(from: url)
		
		guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.cannotParseResponse) }
		
		switch httpResponse.statusCode {
		case 200...299:
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			return try decoder.decode(UsersResponse.self, from: data)
		default:
			throw URLError(.badServerResponse)
		}
	}
	
	
	private func makeURL(to request: RequestType) -> URL? {
		
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
	case fetchUsers(page: Int, count: Int)
	case fetchToken
	case registerUser
}

struct TokenResponse: Decodable {
	let success: Bool
	let token: String
}

struct User: Decodable {
	let id: Int
	let name: String
	let email: String
	let phone: String
	let position: String
	let photo: String
}

struct UsersResponse: Decodable {
	let success: Bool
	let totalPages: Int
	let totalUsers: Int
	let page: Int
	
	let links: UsersLinks
	
	let users: [User]
	
	
	
}

struct UsersLinks: Decodable {
	let nextUrl: String?
	let prevUrl: String?
	
}

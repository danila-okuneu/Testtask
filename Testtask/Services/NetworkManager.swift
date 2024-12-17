//
//  NetworkService.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//



import Foundation


final class NetworkManager {
	
	static let shared = NetworkManager()
	private init() { }
	
	// MARK: - URLSession
	private let session: URLSession = {
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = 30
		configuration.timeoutIntervalForResource = 60
		return URLSession(configuration: configuration)
	}()
	
		
	func fetchToken() async throws -> String {
		
		guard let url = makeURL(to: .token) else { throw URLError(.badURL) }
		
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
	
	func registerUser(userRequest: RegisterUserRequest, token: String) async throws -> RegisterUserResponse {
		guard let url = makeURL(to: .register) else { throw URLError(.badURL) }
			
			var request = URLRequest(url: url)
			request.httpMethod = "POST"
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
			
			let boundary = UUID().uuidString
			request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
			request.setValue(token, forHTTPHeaderField: "Token")
		
		let requestBody = createMultipartBody(with: userRequest, boundary: boundary)
			request.httpBody = requestBody
		
			let (data, response) = try await session.data(for: request)
		

			guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.cannotParseResponse) }
			
			switch httpResponse.statusCode {
			case 200...299:
				print("success")
				let decoder = JSONDecoder()
				return try decoder.decode(RegisterUserResponse.self, from: data)
			default:
				if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
					throw NetworkError.dataResponseError(errorResponse.message)
				}
				throw NetworkError.badServerResponse(statusCode: httpResponse.statusCode)
			}
		}
	
	private func createMultipartBody(with request: RegisterUserRequest, boundary: String) -> Data {
		var body = Data()
		
		func appendField(name: String, value: String) {
			body.append("--\(boundary)\r\n".data(using: .utf8)!)
			body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
			body.append("\(value)\r\n".data(using: .utf8)!)
		}
		
		appendField(name: "name", value: request.name)
		appendField(name: "email", value: request.email)
		appendField(name: "phone", value: request.phone)
		appendField(name: "position_id", value: String(request.positionId))
		
		// Добавляем файл (фото)
		body.append("--\(boundary)\r\n".data(using: .utf8)!)
		body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"photo.jpg\"\r\n".data(using: .utf8)!)
		body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
		body.append(request.photo)
		body.append("\r\n".data(using: .utf8)!)
		
		body.append("--\(boundary)--\r\n".data(using: .utf8)!)
		
		return body
	}
	
	func fetchUsers(page: Int = 1, count: Int = 6) async throws -> UsersResponse {
		guard let url = makeURL(to: .users(page: page, count: count)) else { throw NetworkError.invalidURL }
		let (data, response) = try await session.data(from: url)
		guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.cannotParseResponse) }
		switch httpResponse.statusCode {
		case 200...299:
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			let users = try decoder.decode(UsersResponse.self, from: data)
			return users
		default:
			if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
				throw NetworkError.dataResponseError(errorResponse.message)
			}
			throw NetworkError.badServerResponse(statusCode: httpResponse.statusCode)
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
			throw NetworkError.badServerResponse(statusCode: httpResponse.statusCode)
		}
	}
	
	func fetchPositions() async throws -> PositionResponse {
		guard let url = makeURL(to: .positions) else { throw NetworkError.invalidURL }
		print(url)
		let (data, response) = try await session.data(from: url)
		guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.cannotParseResponse) }
		switch httpResponse.statusCode {
		case 200...299:
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			let positions = try decoder.decode(PositionResponse.self, from: data)
			return positions
		default:
			if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
				throw NetworkError.dataResponseError(errorResponse.message)
			}
			throw NetworkError.badServerResponse(statusCode: httpResponse.statusCode)
		}
		
		
	}
	
	
	
	private func makeURL(to request: RequestType) -> URL? {
		
		var components = URLComponents()
		components.scheme = "https"
		components.host = "frontend-test-assignment-api.abz.agency"
		let basePath = "/api/v1"
		
		switch request {
		case .users(let page, let count):
			components.path = basePath + "/users"
			
			components.queryItems = [
				URLQueryItem(name: "page", value: "\(page)"),
				URLQueryItem(name: "count", value: "\(count)")
			]
		case .token:
			components.path = basePath + "/token"
		case .register:
			components.path = basePath + "/users"
		case .positions:
			components.path = basePath + "/positions"
		}
		return components.url
	}
}

// MARK: - HTTP Method Enum
enum RequestType {
	case users(page: Int, count: Int)
	case token
	case register
	case positions
}

struct TokenResponse: Decodable {
	let success: Bool
	let token: String
}

struct ErrorResponse: Decodable {
	let success: Bool
	let message: String
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

struct RegisterUserRequest: Codable {
	let name: String
	let email: String
	let phone: String
	let positionId: Int
	let photo: Data
	
}

struct RegisterUserResponse: Decodable {
	let success: Bool
	let message: String
	
}

enum NetworkError: Error, LocalizedError {
	case invalidURL
	case badServerResponse(statusCode: Int)
	case decodingError
	case dataResponseError(String)
	
	var errorDescription: String? {
		switch self {
		case .invalidURL:
			return "Invalid URL adress"
		case .badServerResponse(let statusCode):
			return "Error. Status code: \(statusCode)"
		case .decodingError:
			return "Cannot decode response"
		case .dataResponseError(let string):
			return string
		}
	}
}

struct PositionResponse: Decodable {
	let success: Bool
	let positions: [Position]
	
}

struct Position: Decodable, Equatable {
	let id: Int
	let name: String
}

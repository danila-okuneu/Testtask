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
	
		
	// MARK: - Fetch Token
	/// Fetches an authentication token from the server.
	/// - Throws:
	///   - `URLError.badURL` if the URL is invalid.
	///   - `URLError.cannotParseResponse` if the response cannot be parsed.
	///   - `URLError.badServerResponse` for any server-side errors.
	/// - Returns: A valid authentication token as a `String`
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
	
	// MARK: - Register User
	/// Registers a new user by sending their data to the server.
	/// - Parameters:
	///   - userRequest: A `RegisterUserRequest` object containing user details.
	///   - token: A valid authentication token for authorization.
	/// - Throws:
	///   - `URLError.badURL` if the URL is invalid.
	///   - `NetworkError.dataResponseError` if the server returns an error message.
	///   - `NetworkError.badServerResponse` if the response status is not 2xx.
	/// - Returns: A `RegisterUserResponse` containing server confirmation of the registration.
	func registerUser(userRequest: RegisterUserRequest, token: String) async throws -> RegisterUserResponse {
		guard let url = makeURL(to: .register) else { throw URLError(.badURL) }
			
			var request = URLRequest(url: url)
			let boundary = UUID().uuidString
		
			request.httpMethod = "POST"
			request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
			request.setValue(token, forHTTPHeaderField: "Token")
		
		let requestBody = createMultipartBody(with: userRequest, boundary: boundary)
			request.httpBody = requestBody
		
			let (data, response) = try await session.data(for: request)
		

			guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.cannotParseResponse) }
			
			switch httpResponse.statusCode {
			case 200...299:
				let decoder = JSONDecoder()
				return try decoder.decode(RegisterUserResponse.self, from: data)
			default:
				if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
					throw NetworkError.dataResponseError(errorResponse.message)
				}
				throw NetworkError.badServerResponse(statusCode: httpResponse.statusCode)
			}
		}
	
	// MARK: - Create Multipart Body
	/// Builds a multipart/form-data request body for user registration.
	/// - Parameters:
	///   - request: The `RegisterUserRequest` containing user details.
	///   - boundary: A unique string to separate parts of the body.
	/// - Returns: A `Data` object containing the complete multipart body.
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
	
	// MARK: - Fetch Users with Pagination
	/// Fetches a paginated list of users from the server.
	/// - Parameters:
	///   - page: The page number to fetch (default is 1).
	///   - count: The number of users per page (default is 6).
	/// - Throws: `NetworkError` or `URLError` for invalid responses.
	/// - Returns: A `UsersResponse` object containing the list of users.
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
	
	// MARK: - Fetch Users from URL
	/// Fetches a list of users from the provided URL.
	/// - Parameter url: The endpoint URL to fetch users.
	/// - Throws:
	///   - `URLError.cannotParseResponse` if the response is invalid.
	///   - `NetworkError.badServerResponse` if the response status is not in the 2xx range.
	/// - Returns: A `UsersResponse` object containing the list of users.
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
	
	// MARK: - Fetch Positions
	/// Fetches a list of available positions from the server.
	/// - Throws:
	///   - `NetworkError.invalidURL` if the URL cannot be created.
	///   - `URLError.cannotParseResponse` if the response is invalid.
	///   - `NetworkError.dataResponseError` if the server returns an error message.
	///   - `NetworkError.badServerResponse` for responses outside the 2xx range.
	/// - Returns: A `PositionResponse` object containing the list of positions.
	func fetchPositions() async throws -> PositionResponse {
		guard let url = makeURL(to: .positions) else { throw NetworkError.invalidURL }
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
	
	// MARK: - Make URL
	/// Constructs a URL for the specified request type.
	/// - Parameter request: The `RequestType` enum representing the desired endpoint.
	/// - Returns: A valid `URL` object or `nil` if the URL could not be constructed.
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




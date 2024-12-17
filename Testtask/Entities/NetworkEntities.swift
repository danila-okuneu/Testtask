//
//  NetworkResponses.swift
//  Testtask
//
//  Created by Danila Okuneu on 17.12.24.
//

import Foundation

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

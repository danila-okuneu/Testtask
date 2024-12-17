//
//  User.swift
//  Testtask
//
//  Created by Danila Okuneu on 17.12.24.
//

import Foundation

struct UsersResponse: Decodable {
	let success: Bool
	let totalPages: Int
	let totalUsers: Int
	let page: Int
	
	let links: UsersLinks
	
	let users: [User]
}

struct User: Decodable {
	let id: Int
	let name: String
	let email: String
	let phone: String
	let position: String
	let photo: String
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


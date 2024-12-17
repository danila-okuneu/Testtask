//
//  Position.swift
//  Testtask
//
//  Created by Danila Okuneu on 18.12.24.
//

struct PositionResponse: Decodable {
	let success: Bool
	let positions: [Position]
}

struct Position: Decodable, Equatable {
	let id: Int
	let name: String
}

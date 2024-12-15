//
//  UsersInteractor.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import Foundation

// MARK: - Interactor Protocol
protocol UsersInteractorProtocol: AnyObject {
	
	var output: UsersInteractorOutput? { get set }
	
}

protocol UsersInteractorInput: AnyObject {
	
	func fetchUsers(page: Int) async
	func fetchNextPage() async
}

protocol UsersInteractorOutput: AnyObject {
	
	func didFetchUsers(_ response: UsersResponse)
	func didFailToFetchUsers( error: Error)
	
}

// MARK: - Interactor
final class UsersInteractor: UsersInteractorProtocol {
	
	weak var output: UsersInteractorOutput?
	var nextUrl: String?
	var totalPages: Int?
	
}

// MARK: - Input
extension UsersInteractor: UsersInteractorInput {
	func fetchNextPage() async {
		guard let urlString = nextUrl, let url = URL(string: urlString) else { return }
		do {
			print(url)
			let response = try await NetworkService.shared.fetchUsers(from: url)
			self.nextUrl = response.links.nextUrl
			output?.didFetchUsers(response)
		} catch {
			output?.didFailToFetchUsers(error: error)
			
		}
	}
	
	func fetchUsers(page: Int = 1) async {
		do {
			let response = try await NetworkService.shared.fetchUsers(page: page)
			self.nextUrl = response.links.nextUrl
			self.totalPages = response.totalPages
			
			output?.didFetchUsers(response)
		} catch {
			output?.didFailToFetchUsers(error: error)

		}
		
	}
}



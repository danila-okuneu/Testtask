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
	
	func fetchUsers() async
	func fetchNextPage() async
}

protocol UsersInteractorOutput: AnyObject {
	
	func didFetchUsers(_ users: [User])
	func didFailToFetchUsers( error: Error)
	func didLoadAllPages()
	
}

// MARK: - Interactor
final class UsersInteractor: UsersInteractorProtocol {
	
	weak var output: UsersInteractorOutput?
	var nextUrl: String?
	
}

// MARK: - Input
extension UsersInteractor: UsersInteractorInput {
	func fetchNextPage() async {
		guard let urlString = nextUrl, let url = URL(string: urlString) else { return }
		do {
			
			let response = try await NetworkManager.shared.fetchUsers(from: url)
			guard nextUrl != response.links.nextUrl else { return }
			if response.links.nextUrl == nil {
				output?.didLoadAllPages()
			}
			self.nextUrl = response.links.nextUrl
			output?.didFetchUsers(response.users)
		} catch {
			output?.didFailToFetchUsers(error: error)
			
		}
	}
	
	func fetchUsers() async {
		do {
			let response = try await NetworkManager.shared.fetchUsers()
			
			self.nextUrl = response.links.nextUrl
			output?.didFetchUsers(response.users)
			
		} catch {
			output?.didFailToFetchUsers(error: error)

		}
		
	}
}



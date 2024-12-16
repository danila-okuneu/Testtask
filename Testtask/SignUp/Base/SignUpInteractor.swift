//
//  SignUpInteractor.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

// MARK: - Interactor Protocol
protocol SignUpInteractorProtocol: AnyObject {
	
	var output: SignUpInteractorOutput? { get set }
	
}

protocol SignUpInteractorInput: AnyObject {
	
	func registerUser(_ request: RegisterUserRequest) async
	func fetchPositions() async
}

protocol SignUpInteractorOutput: AnyObject {
	
	func didFetchPositions(_ positions: [Position])
	func didFailureToFetchPositions(_ message: String)
	
	func didRegisterUser()
	func didFailureToRegisterUser(_ message: String)
}

// MARK: - Interactor
final class SignUpInteractor: SignUpInteractorProtocol {
	
	weak var output: SignUpInteractorOutput?
	
}

// MARK: - Interactor Input
extension SignUpInteractor: SignUpInteractorInput {

	func registerUser(_ request: RegisterUserRequest) async {
		
		do {
			let token = try await NetworkManager.shared.fetchToken()
			try await NetworkManager.shared.registerUser(userRequest: request, token: token)
			output?.didRegisterUser()
			
		} catch {
			output?.didFailureToRegisterUser(error.localizedDescription)
		}
	}
	
	
	func fetchPositions() async {
		
		do {
			let response = try await NetworkManager.shared.fetchPositions()
			output?.didFetchPositions(response.positions)
		} catch {
			output?.didFailureToFetchPositions(error.localizedDescription)
		}
	}
}



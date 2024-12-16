//
//  SignUpInteractor.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Interactor Protocol
protocol SignUpInteractorProtocol: AnyObject {
	
	var presenter: SignUpInteractorOutput? { get set }
	
}

protocol SignUpInteractorInput: AnyObject {
	
	func fetchPositions() async throws
}

protocol SignUpInteractorOutput: AnyObject {
	
	func didFetchPositions(_ positions: [Position])
	func didFailureToFetchPositions(_ message: String)
}

// MARK: - Interactor
final class SignUpInteractor: SignUpInteractorProtocol {
	
	weak var presenter: SignUpInteractorOutput?
	
}

// MARK: - Input & Output
extension SignUpInteractor: SignUpInteractorInput {
	
	func fetchPositions() async {
		
		do {
			let response = try await NetworkManager.shared.fetchPositions()
			presenter?.didFetchPositions(response.positions)
		} catch {
			presenter?.didFailureToFetchPositions(error.localizedDescription)
		}
	}
}



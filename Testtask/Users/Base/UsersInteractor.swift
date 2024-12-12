//
//  UsersInteractor.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Interactor Protocol
protocol UsersInteractorProtocol: AnyObject {
	
	var presenter: UsersPresenterProtocol? { get set }
	
}

protocol UsersInteractorInputs: AnyObject {
	
	// Define input methods
}

protocol UsersInteractorOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Interactor
final class UsersInteractor: UsersInteractorProtocol {
	
	weak var presenter: UsersPresenterProtocol?
	
}

// MARK: - Input & Output
extension UsersInteractor: UsersInteractorInputs, UsersInteractorOutputs {
	
	// Extend functionality
}



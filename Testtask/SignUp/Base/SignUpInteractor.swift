//
//  SignUpInteractor.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Interactor Protocol
protocol SignUpInteractorProtocol: AnyObject {
	
	var presenter: SignUpPresenterProtocol? { get set }
	
}

protocol SignUpInteractorInputs: AnyObject {
	
	// Define input methods
}

protocol SignUpInteractorOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Interactor
final class SignUpInteractor: SignUpInteractorProtocol {
	
	weak var presenter: SignUpPresenterProtocol?
	
}

// MARK: - Input & Output
extension SignUpInteractor: SignUpInteractorInputs, SignUpInteractorOutputs {
	
	// Extend functionality
}



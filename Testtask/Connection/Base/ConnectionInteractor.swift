//
//  ConnectionInteractor.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Interactor Protocol
protocol ConnectionInteractorProtocol: AnyObject {
	
	var presenter: ConnectionPresenterProtocol? { get set }
	
}

protocol ConnectionInteractorInputs: AnyObject {
	
	// Define input methods
}

protocol ConnectionInteractorOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Interactor
final class ConnectionInteractor: ConnectionInteractorProtocol {
	
	weak var presenter: ConnectionPresenterProtocol?
	
}

// MARK: - Input & Output
extension ConnectionInteractor: ConnectionInteractorInputs, ConnectionInteractorOutputs {
	
	// Extend functionality
}



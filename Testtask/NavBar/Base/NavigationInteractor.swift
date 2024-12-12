//
//  NavigationInteractor.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Interactor Protocol
protocol NavigationInteractorProtocol: AnyObject {
	
	var presenter: NavigationPresenterProtocol? { get set }
	
}

protocol NavigationInteractorInputs: AnyObject {
	
	// Define input methods
}

protocol NavigationInteractorOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Interactor
final class NavigationInteractor: NavigationInteractorProtocol {
	
	weak var presenter: NavigationPresenterProtocol?
	
}

// MARK: - Input & Output
extension NavigationInteractor: NavigationInteractorInputs, NavigationInteractorOutputs {
	
	// Extend functionality
}



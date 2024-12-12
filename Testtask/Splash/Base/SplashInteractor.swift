//
//  SplashInteractor.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Interactor Protocol
protocol SplashInteractorProtocol: AnyObject {
	
	var presenter: SplashPresenterProtocol? { get set }
	
}

protocol SplashInteractorInputs: AnyObject {
	
	// Define input methods
}

protocol SplashInteractorOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Interactor
final class SplashInteractor: SplashInteractorProtocol {
	
	weak var presenter: SplashPresenterProtocol?
	
}

// MARK: - Input & Output
extension SplashInteractor: SplashInteractorInputs, SplashInteractorOutputs {
	
	// Extend functionality
}



//
//  TabInteractor.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Interactor Protocol
protocol TabInteractorProtocol: AnyObject {
	
	var presenter: TabPresenterProtocol? { get set }
	
}

protocol TabInteractorInputs: AnyObject {
	
	// Define input methods
}

protocol TabInteractorOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Interactor
final class TabInteractor: TabInteractorProtocol {
	
	weak var presenter: TabPresenterProtocol?
	
}

// MARK: - Input & Output
extension TabInteractor: TabInteractorInputs, TabInteractorOutputs {
	
	// Extend functionality
}



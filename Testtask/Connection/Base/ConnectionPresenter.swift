//
//  ConnectionPresenter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Presenter Protocol
protocol ConnectionPresenterProtocol: AnyObject {
	
	var view: ConnectionViewProtocol? { get set }
	var interactor: ConnectionInteractorProtocol? {get set }
	
}

protocol ConnectionPresenterInputs: AnyObject {
	
	// Define input methods
}

protocol ConnectionPresenterOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Presenter
final class ConnectionPresenter: ConnectionPresenterProtocol {
	
	weak var view: ConnectionViewProtocol?
	var interactor: ConnectionInteractorProtocol?
	
	init(view: ConnectionViewProtocol?, interactor: ConnectionInteractorProtocol?) {
		self.view = view
		self.interactor = interactor
	}
}

// MARK: - Input & Output
extension ConnectionPresenter: ConnectionPresenterInputs, ConnectionPresenterOutputs {
	
	// Extend functionality
}


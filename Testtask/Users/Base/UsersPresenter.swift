//
//  UsersPresenter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Presenter Protocol
protocol UsersPresenterProtocol: AnyObject {
	
	var view: UsersViewProtocol? { get set }
	var interactor: UsersInteractorProtocol? {get set }
	
}

protocol UsersPresenterInputs: AnyObject {
	
	// Define input methods
}

protocol UsersPresenterOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Presenter
final class UsersPresenter: UsersPresenterProtocol {
	
	weak var view: UsersViewProtocol?
	var interactor: UsersInteractorProtocol?
	
	init(view: UsersViewProtocol?, interactor: UsersInteractorProtocol?) {
		self.view = view
		self.interactor = interactor
	}
}	

// MARK: - Input & Output
extension UsersPresenter: UsersPresenterInputs, UsersPresenterOutputs {
	
	// Extend functionality
}


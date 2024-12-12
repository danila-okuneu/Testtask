//
//  NavigationPresenter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Presenter Protocol
protocol NavigationPresenterProtocol: AnyObject {
	
	var view: NavigationViewProtocol? { get set }
	var interactor: NavigationInteractorProtocol? {get set }
	
}

protocol NavigationPresenterInputs: AnyObject {
	
	// Define input methods
}

protocol NavigationPresenterOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Presenter
final class NavigationPresenter: NavigationPresenterProtocol {
	
	weak var view: NavigationViewProtocol?
	var interactor: NavigationInteractorProtocol?
	
	init(view: NavigationViewProtocol?, interactor: NavigationInteractorProtocol?) {
		self.view = view
		self.interactor = interactor
	}
}

// MARK: - Input & Output
extension NavigationPresenter: NavigationPresenterInputs, NavigationPresenterOutputs {
	
	// Extend functionality
}


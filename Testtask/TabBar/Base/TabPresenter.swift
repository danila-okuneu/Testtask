//
//  Untitled.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Presenter Protocol
protocol TabPresenterProtocol: AnyObject {
	
	var view: TabViewProtocol? { get set }
	var interactor: TabInteractorProtocol? {get set }
	
}

protocol TabPresenterInputs: AnyObject {
	
	// Define input methods
}

protocol TabPresenterOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Presenter
final class TabPresenter: TabPresenterProtocol {
	
	weak var view: TabViewProtocol?
	var interactor: TabInteractorProtocol?
	
	init(view: TabViewProtocol?, interactor: TabInteractorProtocol?) {
		self.view = view
		self.interactor = interactor
	}
}

// MARK: - Input & Output
extension TabPresenter: TabPresenterInputs, TabPresenterOutputs {
	
	// Extend functionality
}


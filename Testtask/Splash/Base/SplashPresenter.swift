//
//  SplashPresenter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Presenter Protocol
protocol SplashPresenterProtocol: AnyObject {
	
	var view: SplashViewProtocol? { get set }
	var interactor: SplashInteractorProtocol? {get set }
	
}

protocol SplashPresenterInputs: AnyObject {
	
	// Define input methods
}

protocol SplashPresenterOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Presenter
final class SplashPresenter: SplashPresenterProtocol {
	
	weak var view: SplashViewProtocol?
	var interactor: SplashInteractorProtocol?
		
	init(view: SplashViewProtocol?, interactor: SplashInteractorProtocol?) {
		self.view = view
		self.interactor = interactor
	}
}

// MARK: - Input & Output
extension SplashPresenter: SplashPresenterInputs, SplashPresenterOutputs {
	
	// Extend functionality
}


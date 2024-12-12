//
//  SignUpPresenter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Presenter Protocol
protocol SignUpPresenterProtocol: AnyObject {
	
	var view: SignUpViewProtocol? { get set }
	var interactor: SignUpInteractorProtocol? {get set }
	
}

protocol SignUpPresenterInputs: AnyObject {
	
	// Define input methods
}

protocol SignUpPresenterOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Presenter
final class SignUpPresenter: SignUpPresenterProtocol {
	
	weak var view: SignUpViewProtocol?
	var interactor: SignUpInteractorProtocol?
	
	init(view: SignUpViewProtocol?, interactor: SignUpInteractorProtocol?) {
		self.view = view
		self.interactor = interactor
	}
}

// MARK: - Input & Output
extension SignUpPresenter: SignUpPresenterInputs, SignUpPresenterOutputs {
	
	// Extend functionality
}


//
//  SignUpPresenter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import Dispatch

// MARK: - Presenter Protocol
protocol SignUpPresenterProtocol: AnyObject {
	
	var view: SignUpViewController? { get set }
	var interactor: SignUpInteractor? {get set }
	
}

protocol SignUpPresenterInputs: AnyObject {
	
	func viewWillAppear()
}

protocol SignUpPresenterOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Presenter
final class SignUpPresenter: SignUpPresenterProtocol {
	
	weak var view: SignUpViewController?
	var interactor: SignUpInteractor?
	
	init(view: SignUpViewController?, interactor: SignUpInteractor?) {
		self.view = view
		self.interactor = interactor
	}
}

// MARK: - Input
extension SignUpPresenter: SignUpPresenterInputs {
	
	func viewWillAppear() {
		Task {
			await interactor?.fetchPositions()
		}
	}
	
	
	
}


// MARK: - Output
extension SignUpPresenter: SignUpInteractorOutput {
	
	func didFetchPositions(_ positions: [Position]) {
		view?.loadPositions(positions)
	}
	
	func didFailureToFetchPositions(_ message: String = "Failure to fetch positions") {
		print("Failure")
		DispatchQueue.main.sync {
			view?.showErrorAlert(message: message)
		}
	}
	
	
	
	
}

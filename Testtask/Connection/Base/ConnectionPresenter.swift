//
//  ConnectionPresenter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

// MARK: - Presenter Protocol
protocol ConnectionPresenterProtocol: AnyObject {
	
	var view: ConnectionViewController? { get set }
	var interactor: ConnectionInteractorInputs? {get set }
	
}



protocol ConnectionPresenterOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Presenter
final class ConnectionPresenter: ConnectionPresenterProtocol {
	
	weak var view: ConnectionViewController?
	var interactor: ConnectionInteractorInputs?
	
	init(view: ConnectionViewController?, interactor: ConnectionInteractorInputs?) {
		self.view = view
		self.interactor = interactor
	}
	
	func changeController(to controller: UIViewController) {
		
		if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
			guard let window = scene.windows.first else { return }
			
			window.rootViewController = controller
		}
	}
}


// MARK: - View Outputs
extension ConnectionPresenter: ConnectionViewOutputs {
	
	func didTapTryAgain() {
		interactor?.checkInternetConnection()
	}
}

// MARK: - Interactor Outputs
extension ConnectionPresenter: ConnectionInteractorOutputs {
	
	func didDetectInternetConnection() {
		changeController(to: TabRouter.start())
	}
	
	func didFailInternetConnection() {
		view?.showErrorAlert(message: "Please, check your Wifi or cellular internet connection", title: "No connection")
	}
	
	
	
	
}

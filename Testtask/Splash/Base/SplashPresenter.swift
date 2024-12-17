//
//  SplashPresenter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

// MARK: - Presenter Protocol
protocol SplashPresenterProtocol: AnyObject {
	
	var view: SplashViewInputs? { get set }
	var interactor: SplashInteractorInputs? { get set }
	
}

protocol SplashPresenterOutputs: AnyObject {
	
	func changeController(to controller: UIViewController)
}

// MARK: - Presenter
final class SplashPresenter: SplashPresenterProtocol {
	
	weak var view: SplashViewInputs?
	var interactor: SplashInteractorInputs?
		
	init(view: SplashViewInputs?, interactor: SplashInteractorInputs?) {
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
extension SplashPresenter: SplashViewOutputs {
	
	func viewWillAppear() {
		interactor?.checkInternetConnection()
	}
}

extension SplashPresenter: SplashInteractorOutputs {
	
	
	func didDetectInternetConnection() {
		changeController(to: TabRouter.start())
	}
	
	func didFailInternetConnection() {
		changeController(to: ConnectionRouter.start())
	}
	
}

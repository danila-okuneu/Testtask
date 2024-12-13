//
//  SplashPresenter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

// MARK: - Presenter Protocol
protocol SplashPresenterProtocol: AnyObject {
	
	var view: SplashViewProtocol? { get set }
	var interactor: SplashInteractorProtocol? {get set }
	
}

protocol SplashPresenterInputs: AnyObject {
	
	// Define input methods
	
	func endLoading()
	
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
	
	func endLoading() {
		changeController()
	}
	
	private func changeController() {
		
		if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
			guard let window = scene.windows.first else { return }
			
			
			let controller = SignUpRouter.start()
			
			UIView.transition(with: window, duration: 0.3) {
				window.rootViewController = controller
			}
			
			
		}
		
		
	}
	// Extend functionality
}


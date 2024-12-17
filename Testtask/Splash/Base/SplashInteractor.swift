//
//  SplashInteractor.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Interactor Protocol
protocol SplashInteractorProtocol: AnyObject {
	
	var output: SplashInteractorOutputs? { get set }
	
}

protocol SplashInteractorInputs: AnyObject {
	
	func checkInternetConnection()
}

protocol SplashInteractorOutputs: AnyObject {
	
	func didDetectInternetConnection()
	func didFailInternetConnection()
}

// MARK: - Interactor
final class SplashInteractor: SplashInteractorProtocol, SplashInteractorInputs {
	
	weak var output: SplashInteractorOutputs?
	
	func checkInternetConnection() {
		NetworkMonitor.shared.checkConnection{ isConnected in
			if isConnected {
				self.output?.didDetectInternetConnection()
			} else {
				self.output?.didFailInternetConnection()
			}
		}
	}
}

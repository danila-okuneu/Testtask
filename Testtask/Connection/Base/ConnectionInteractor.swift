//
//  ConnectionInteractor.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Interactor Protocol
protocol ConnectionInteractorProtocol: AnyObject {
	
	var output: ConnectionInteractorOutputs? { get set }
	
}

protocol ConnectionInteractorInputs: AnyObject {
	
	func checkInternetConnection()
}

protocol ConnectionInteractorOutputs: AnyObject {
	
	func didDetectInternetConnection()
	func didFailInternetConnection()
}

// MARK: - Interactor
final class ConnectionInteractor: ConnectionInteractorProtocol {
	
	weak var output: ConnectionInteractorOutputs?
	
}

// MARK: - Input & Output
extension ConnectionInteractor: ConnectionInteractorInputs {
	
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



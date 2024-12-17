//
//  ConnectionRounter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

// MARK: - Protocol
protocol ConnectionRouterProtocol: AnyObject {
	
	var entry: UIViewController? { get }
	
}

protocol ConnectionRouterOutputs: AnyObject {
	
	static func start() -> UIViewController
	
}

// MARK: - Router
final class ConnectionRouter: ConnectionRouterProtocol, ConnectionRouterOutputs {
	var entry: UIViewController?
	
	
	static func start() -> UIViewController {
		
		let view = ConnectionViewController(nibName: nil, bundle: nil)
		let interactor = ConnectionInteractor()
		let presenter = ConnectionPresenter(view: view, interactor: interactor)
		
		view.presenter = presenter
		interactor.output = presenter
		
		return view
	}
	
	
	
}


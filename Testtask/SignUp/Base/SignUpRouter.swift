//
//  SignUpRouter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

// MARK: - Protocol
protocol SignUpRouterProtocol: AnyObject {
	
	var entry: UIViewController? { get }
	
}

protocol SignUpRouterOutputs: AnyObject {
	
	static func start() -> UIViewController
	
}

// MARK: - Router
final class SignUpRouter: SignUpRouterProtocol, SignUpRouterOutputs {
	var entry: UIViewController?
	
	
	static func start() -> UIViewController {
		
		let view = SignUpViewController(nibName: nil, bundle: nil)
		let interactor = SignUpInteractor()
		let presenter = SignUpPresenter(view: view, interactor: interactor)
		
		view.presenter = presenter
		interactor.presenter = presenter
		
		return view
	}
	
	
	
}


//
//  UsersRouter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

// MARK: - Protocol
protocol UsersRouterProtocol: AnyObject {
	
	static func start() -> UIViewController
}

// MARK: - Router
final class UsersRouter: UsersRouterProtocol {
	
	static func start() -> UIViewController {
		
		let view = UsersViewController(nibName: nil, bundle: nil)
		let interactor = UsersInteractor()
		let presenter = UsersPresenter(view: view, interactor: interactor)
		
		view.presenter = presenter
		interactor.output = presenter
		
		return view
	}
}


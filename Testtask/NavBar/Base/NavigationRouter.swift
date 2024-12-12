//
//  NavigationRouter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

// MARK: - Protocol
protocol NavigationRouterProtocol: AnyObject {
	
	var entry: UIViewController? { get }
	
}

protocol NavigationRouterOutputs: AnyObject {
	
	static func start() -> UIViewController
	
}

// MARK: - Router
final class NavigationRouter: NavigationRouterProtocol, NavigationRouterOutputs {
	var entry: UIViewController?
	
	
	static func start() -> UIViewController {
		
		let view = NavigationViewController(nibName: nil, bundle: nil)
		let interactor = NavigationInteractor()
		let presenter = NavigationPresenter(view: view, interactor: interactor)
		
		view.presenter = presenter
		interactor.presenter = presenter
		
		return view
	}
	
	
	
}


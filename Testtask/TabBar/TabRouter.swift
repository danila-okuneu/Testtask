//
//  MainRouter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

// MARK: - Protocol
protocol TabRouterProtocol: AnyObject {
	
	var entry: UIViewController? { get }
		
}

protocol TabRouterOutputs: AnyObject {
	
	static func start() -> UIViewController
	
}

// MARK: - Router
final class TabRouter: TabRouterProtocol, TabRouterOutputs {
	var entry: UIViewController?
	
	
	static func start() -> UIViewController {
		
		let view = TabViewController(nibName: nil, bundle: nil)
		let interactor = TabInteractor()
		let presenter = TabPresenter(view: view, interactor: interactor)
		
		view.presenter = presenter
		interactor.presenter = presenter
		
		return view
	}
	
	
	
}


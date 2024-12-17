//
//  SplashRouter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

// MARK: - Protocol
protocol SplashRouterProtocol: AnyObject {
	
	static func start() -> UIViewController
	
}

// MARK: - Router
final class SplashRouter: SplashRouterProtocol {
	var entry: UIViewController?
	
	
	static func start() -> UIViewController {
		
		let view = SplashViewController(nibName: nil, bundle: nil)
		let interactor = SplashInteractor()
		let presenter = SplashPresenter(view: view, interactor: interactor)
		
		
		view.presenter = presenter
		interactor.output = presenter
		
		return view
	}
	
	
	
}




//
//  TabRouter.swift
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
		
		let view = TabViewController()
		let interactor = TabInteractor()
		let presenter = TabPresenter()
	
		view.presenter = presenter
		
		presenter.view = view
		presenter.interactor = interactor
	
		interactor.presenter = presenter
		view.addTab(UsersRouter.start().navigated(), title: "Users", image: UIImage(systemName: "person.3.sequence.fill"), selectedImage: nil)
		
		view.addTab(SignUpRouter.start().navigated(), title: "Sign Up", image: UIImage(systemName: "person.crop.circle.badge.plus"), selectedImage: nil)
		
		return view
	}
	
	
	
}


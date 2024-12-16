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

// MARK: - Router
final class TabRouter: TabRouterProtocol {
	var entry: UIViewController?
	
	static func start() -> UIViewController {
		let view = TabViewController()
		let presenter = TabPresenter()
		
		view.presenter = presenter
		presenter.view = view
		return view
	}
}


//
//  Untitled.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

// MARK: - Presenter Protocol
protocol TabPresenterProtocol: AnyObject {
	
	var view: TabViewController? { get set }
	
}

protocol TabPresenterInputs {
	
	func viewWillAppear()
}

protocol TabPresenterOutputs {
	
	func setupTabs()
}

// MARK: - Presenter
final class TabPresenter: TabPresenterProtocol {
	
	
	weak var view: TabViewController?

	var isSetuped = false
}


// MARK: - Inputs
extension TabPresenter: TabPresenterInputs {
	
	
	
	func viewWillAppear() {
		guard !isSetuped else { return }
		view?.setupTabBar()
		setupTabs()
	}
		
}

// MARK: - Outputs
extension TabPresenter: TabPresenterOutputs {
	
	func setupTabs() {
		isSetuped = true
		view?.addTab(UsersRouter.start().navigated(), title: "Users", image: UIImage(systemName: "person.3.sequence.fill"), selectedImage: nil)
		
		view?.addTab(SignUpRouter.start().navigated(), title: "Sign Up", image: UIImage(systemName: "person.crop.circle.badge.plus"), selectedImage: nil)
	}
	
}

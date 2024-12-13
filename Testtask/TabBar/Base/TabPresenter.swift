//
//  Untitled.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

// MARK: - Presenter Protocol
protocol TabPresenterProtocol: AnyObject {
	
	var view: TabViewInputs? { get set }
	var interactor: TabInteractorProtocol? {get set }
	
	
	func viewWillAppear()
}

// MARK: - Presenter
final class TabPresenter: TabPresenterProtocol {
	
	weak var view: TabViewInputs?
	var interactor: TabInteractorProtocol?
	
	let usersModule = UsersRouter.start()
	let signUpModule = SignUpRouter.start()
	
	
	init(view: TabViewInputs?, interactor: TabInteractorProtocol?) {
		self.view = view
		self.interactor = interactor
	}
}

// MARK: - Input & Output
extension TabPresenter {
	
	func viewWillAppear() {
		
		view?.addTab(signUpModule.navigated(), title: "Sign Up", image: UIImage(systemName: "person.3.sequence.fill"), selectedImage: nil)
	}
	
	
	// Extend functionality
}


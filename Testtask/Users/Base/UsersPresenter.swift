//
//  UsersPresenter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Presenter Protocol
protocol UsersPresenterProtocol: AnyObject {
	
	var view: UsersViewInputs? { get set }
	var interactor: UsersInteractorInput? { get set }
	
}

protocol UsersPresenterInput: AnyObject {
	
	func viewWillAppear()
}

protocol UsersPresenterOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Presenter
final class UsersPresenter: UsersPresenterProtocol {
	
	weak var view: UsersViewInputs?
	var interactor: UsersInteractorInput?
	
	init(view: UsersViewInputs?, interactor: UsersInteractorInput?) {
		self.view = view
		self.interactor = interactor
	}
}	

// MARK: - Input
extension UsersPresenter: UsersPresenterInput {
	
	func viewWillAppear() {
		Task {
			await interactor?.fetchUsers(page: 1)
		}
	}
}

// MARK: - Interactor Output
extension UsersPresenter: UsersInteractorOutput, UsersViewOutputs {
	func userDidScrollToEnd() async {
		await interactor?.fetchNextPage()
	}
	
	func didFailToFetchUsers(error: any Error) {
		print("Can't fetch users")
	}
	
	func didFetchUsers(_ response: UsersResponse) {
		view?.updateUsers(response.users, count: response.totalUsers)
	}
	
	
	
	
}

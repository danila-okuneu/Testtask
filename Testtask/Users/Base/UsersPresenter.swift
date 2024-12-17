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
	
	
}

// MARK: - Presenter
final class UsersPresenter: UsersPresenterProtocol {
	
	weak var view: UsersViewInputs?
	var interactor: UsersInteractorInput?
	
	var isUsersLoaded = false
	
	init(view: UsersViewInputs?, interactor: UsersInteractorInput?) {
		self.view = view
		self.interactor = interactor
	}
}	

// MARK: - Input
extension UsersPresenter: UsersPresenterInput {
	
	func viewWillAppear() {
		Task {
			guard !isUsersLoaded else { return }
			await interactor?.fetchUsers()
			isUsersLoaded = true
		}
	}
}

// MARK: - Interactor Output
extension UsersPresenter: UsersInteractorOutputs {
	
	func didLoadAllPages() {
		view?.didLoadAllPages()
	}
	
	func didFailToFetchUsers(error: any Error) {
		view?.showsActivity(true)
	}
	
	
	func didFetchUsers(_ users: [User]) {
		view?.showsActivity(true)
		view?.loadUsers(users)
	}
}

extension UsersPresenter: UsersViewOutputs {
	
	func didRefreshTable() async {
		await interactor?.fetchUsers()
	}
	
	func didScrollToEnd() async {
		view?.showsActivity(false)
		await interactor?.fetchNextPage()
	}
}

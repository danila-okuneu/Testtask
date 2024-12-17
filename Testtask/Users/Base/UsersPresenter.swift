//
//  UsersPresenter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Presenter Protocol
protocol UsersPresenterProtocol: AnyObject {
	
	var view: UsersViewInputs? { get set }
	var interactor: UsersInteractorInputs? { get set }
	
}

// MARK: - Presenter
final class UsersPresenter: UsersPresenterProtocol {
	
	weak var view: UsersViewInputs?
	var interactor: UsersInteractorInputs?
	
	var isUsersLoaded = false
	
	init(view: UsersViewInputs?, interactor: UsersInteractorInputs?) {
		self.view = view
		self.interactor = interactor
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

// MARK: - View Output
extension UsersPresenter: UsersViewOutputs {
	
	func viewWillAppear() {
		Task {
			guard !isUsersLoaded else { return }
			await interactor?.fetchUsers()
			isUsersLoaded = true
		}
	}
	
	func didRefreshTable() async {
		await interactor?.fetchUsers()
	}
	
	func didScrollToEnd() async {
		view?.showsActivity(false)
		await interactor?.fetchNextPage()
	}
}

//
//  UsersPresenter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

// MARK: - Presenter Protocol
protocol UsersPresenterProtocol: AnyObject {
	
	var view: UsersViewInput? { get set }
	var interactor: UsersInteractorInput? { get set }
	
}

protocol UsersPresenterInput: AnyObject {
	
	func viewWillAppear()
	
}

protocol UsersPresenterOutputs: AnyObject {
	
	
}

// MARK: - Presenter
final class UsersPresenter: UsersPresenterProtocol {
	
	weak var view: UsersViewInput?
	var interactor: UsersInteractorInput?
	
	init(view: UsersViewInput?, interactor: UsersInteractorInput?) {
		self.view = view
		self.interactor = interactor
	}
}	

// MARK: - Input
extension UsersPresenter: UsersPresenterInput {
	
	func viewWillAppear() {
		Task {
			await interactor?.fetchUsers()
		}
	}
}

// MARK: - Interactor Output
extension UsersPresenter: UsersInteractorOutput, UsersViewOutputs {
	func userDidScrollToEnd() async {
		print("User Did Scroll to End")
		view?.activityIsHidden(false)
		await interactor?.fetchNextPage()
	}
	
	func didLoadAllPages() {
		print("Did load All pages")
		view?.didLoadAllPages()
	}
	
	func didFailToFetchUsers(error: any Error) {
		print("Can't fetch users")
	}
	
	
	func didFetchUsers(_ users: [User]) {
		view?.activityIsHidden(true)
		view?.loadUsers(users)
	}
}
